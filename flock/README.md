flock(2) stands for file lock, and is a system call that applies or removes an advisory lock on an open file (i.e. a file handle).
flock(1) is a command line tool for Linux and other POSIX compliant systems. It allows shell scripts to take advantage if dile locking capabilities. Ironically, flock(1) the command line utility doesn't use flock(2) the system call, but instead uses fcntl(2), which provides similar but superior functiinality. 

If you've ever read an Operating Systems textbook, like thise used in Computer Science / Engineering courses, you might remember that you can use file locking as a mutex (or binary semaphore) for the purpose of process synchronization.

flocktest0
flocktest1
flocktest2
flocktest3
flocktest4
flocktest5
flocktest6
flocktest7
