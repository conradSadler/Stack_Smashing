## Build docker image
`docker build -t project4 .`

If you get an error like `permission denied while trying to connect to the Docker daemon`:
    -add yourself to a docker group: `sudo groupadd docker && sudo usermod -aG docker $USER`
    -Check the persmission of the docker socket, make sure you can access `sudo chmod 666 /var/run/docker.sock`


## Run docker image
`docker run --privileged -it -v ./:/home/ubuntu/project4 project4`

## Complie assembly file(test.s) into a object file(test.o) for a 32 bit machine(-m32) using compiler gcc(GAS(AT&T format) as opposed to NASM(Intel format)
`gcc -m32 -c test.s -o test.o`

## Copy only the text section of the object file as binary and put it into rev2.bin
`objcopy -O binary --only-section=.text test.o rev2.bin`

## The following used to install netcat on the docker container
`sudo apt install netcat-openbsd`

## The following command is used to start up a new shell in the docker container(sleepy_austin is my container name) for target 9.
`sudo docker exec -it sleepy_austin /bin/bash`
# Resources for target 9
https://www.man7.org/linux/man-pages/man2/socketcall.2.html

https://www.man7.org/linux/man-pages/man7/ip.7.html

https://www.man7.org/linux/man-pages/man2/connect.2.html

https://www.man7.org/linux/man-pages/man2/dup.2.html

https://cboard.cprogramming.com/c-programming/108182-redirecting-stdout-socket.html

https://github.com/Xre0uS/linux-reverse-shell-in-assembly/blob/main/template.asm

Note: Targets 1 -> 6 and 9 are completed under cookie 36257

Note: Mac may need to provide: `--platform linux/amd64`





