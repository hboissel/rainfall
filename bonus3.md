bonus3:71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587

expect an arguement, send `""` and gives a shell

The binary read the `.pass`, make an atoi on the first argument and place a `\0` at this index on the `.pass`
Then to open a shell, `.pass` content must be equal to the first argument which is impossible.
The only solution is to send `""` this way `atoi()=0` so the content of `.pass` saved become a null string
and ours is one. WE GET A SHELL 

.pass => `3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c`

