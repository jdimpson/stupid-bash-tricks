[flock(2)](https://linux.die.net/man/2/flock) stands for [file lock](https://en.m.wikipedia.org/wiki/File_locking), and is a system call that applies or removes an [advisory lock](https://en.m.wikipedia.org/wiki/Lock_(computer_science)#Types) on an open file (i.e. a file handle).
[flock(1)](https://linux.die.net/man/1/flock) is a command line tool for Linux and other POSIX compliant systems. It allows shell scripts to take advantage if dile locking capabilities. ~~Ironically, flock(1) the command line utility doesn't use flock(2) the system call, but instead uses [fcntl(2)](https://linux.die.net/man/2/fcntl), which provides similar but superior functionality.~~ (This may only be true on systems that dont implement native versions of flock(2))

If you've ever read an Operating Systems textbook, like those used in Computer Science / Engineering courses, you might remember that you can use file locking as a [mutex](https://en.m.wikipedia.org/wiki/Semaphore_(programming)#Semaphores_vs._mutexes) (or binary semaphore) for the purpose of process [synchronization](https://en.m.wikipedia.org/wiki/Synchronization_(computer_science)#Thread_or_process_synchronization). 

In fact, many of the tools/mechanisms used to achieve synchronization can be used to implement the others; therefore implementations of OSes or VMs may only implement one "natively", then use it to build the others. In that spirit, I used [flock(2)](https://linux.die.net/man/2/flock) to synchronize [bash](https://linux.die.net/man/1/bash) shell scripts. 

flocktest0 -- 

flocktest1 -- 

flocktest2 -- 

flocktest3 -- 

flocktest4 -- 

flocktest5 -- 

flocktest6 -- 

flocktest7 -- 
