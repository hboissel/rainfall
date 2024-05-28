bonus1:cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9

# Reconnaissance

first argument => a number which must be under or equal to 9
second arguemnt => string that will be copied in the buffer before the number

By testing with ltrace, we find out that 4 * (atoi(argv1)) is copied into a buffer

In gdb, we see that the nb returned  by atoi is compared to `0x574F4C46`

# Exploit

We have to overwrite the nb return by atoi to make it equal to `1464814662` = `0x574F4C46` = `WOLF`

With 9, we can write 32 bytes but we need to write 44 bytes.
We can use negative numbers. To get 44 bytes at the end, we have to find a value 
which once multiplied by 4, overflow and give 44 (40 to fill up the buffer + 4 for the new value of nb),44 = `0x2c` 44/4 = 11 = `0xb`
-2147483667 = `0x80000000` + `0xb` = `0x8000000` = `-2147483637` as signed int

so first argument => -2147483637
second argument => `python -c 'print "A" * 40 + "FLOW"'`