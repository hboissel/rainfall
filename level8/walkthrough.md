level8:5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9

# Reconnaissance

binary ask for entry after having printed `auth` and `service` pointer address

In gdb, we notice that there is 4 commands:

The program asks for command: `auth `, `reset`, `service`, `login`
`auth ` -> malloc(4) in auth pointer and strcpy what we entered after the first five char into auth malloc. ex: `auth coucou` -> *auth = "coucou"
`reset` -> free auth pointer
`service` -> strdup what is after the 7th char into service pointer
`login` -> check if there is something in *(auth + 0x20), if there is : opens a shell otherwise print "Password:\n"

# Exploit

each malloc is allocated next to each other and the condition for getting the shell requires to have something written at `auth + 0x20` = `auth + 32`
We should initialize the auth pointer by running `auth ` command
then we can run `service` with a padding of 16 in order to reach auth+0x20
or run several `service` command in order to write at `auth + 0x20`
-> service malloc 0x10 after the last malloc so to reach auth+0x20, we need to write 16 characters

