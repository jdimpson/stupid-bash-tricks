# flock hacks
[flock(2)](https://linux.die.net/man/2/flock) stands for [file lock](https://en.m.wikipedia.org/wiki/File_locking), and is a system call that applies or removes an [advisory lock](https://en.m.wikipedia.org/wiki/Lock_(computer_science)#Types) on an open file (i.e. a file handle).
[flock(1)](https://linux.die.net/man/1/flock) is a command line tool for Linux and other POSIX compliant systems. It allows shell scripts to take advantage if file locking capabilities. ~~Ironically, flock(1) the command line utility doesn't use flock(2) the system call, but instead uses [fcntl(2)](https://linux.die.net/man/2/fcntl), which provides similar but superior functionality.~~ (This may only be true on systems that dont implement native versions of flock(2))

If you've ever read an Operating Systems textbook, like those used in Computer Science / Engineering courses, you might remember that you can use file locking as a [mutex](https://en.m.wikipedia.org/wiki/Semaphore_(programming)#Semaphores_vs._mutexes) (or binary semaphore) for the purpose of process [synchronization](https://en.m.wikipedia.org/wiki/Synchronization_(computer_science)#Thread_or_process_synchronization). 

In fact, many of the tools/mechanisms used to achieve synchronization can be used to implement the others; therefore implementations of OSes or VMs may only implement one "natively", then use it to build the others. In that spirit, I used [flock(2)](https://linux.die.net/man/2/flock) primitive to provide process synchronization to [bash](https://linux.die.net/man/1/bash) shell scripts. 

# examples

Most of these examples are intended to be run in near concurrency. Open up two different bash shell prompts, and run the same command once each in either shell. In fact, do them in three different shells if you can. They will show various behaviors that might be desirable if you have any sort of automation that might run the same script more than once at a time. 

There are actually very few behavioral differences in these examples. Instead they differ in how they setup the locks, which is relevant to how you might integrate them into your shell script.

`flocktest0` -- Simplest example of an write / exclusive lock (`flock -x`). Whichever process starts first will get the lock. Subsequent instances of the script *will block* until the first one exits (which releases the lock). Good way to ensure that a bunch of instances all get run, but only one at a time. This uses an external temporary file to synchronize on. 

`flocktest1` -- Similar to the previous, but subsequent instances will not block, but will exit. This is a neat way to ensure a script only ever runs once, and that any instance that is not allowed to run can treat the situation like an error rather than being blocked. I think of it as a way to handle hysteresis. Imagine a script that runs when someone presses a button. There is a good chance that when pressing the button, it actually gets tapped a few times in rapid succession. That could cause the script to run several times. This could be used as a software debounce implementation.

`flocktest2` -- Behaviourally, this works just like `flocktest0` (first instance gets the lock, the rest block until the lock is released). But this one uses subshells to limit the *critical section* (the section of code protected by the lock / mutex) to only a limited portion of the code. This would be useful to if you some of your script can run concurrently, but specific section(s) must be serialized.

`flocktest3` -- Behaves like `flocktest1` (subsequent instances will exit without the lock), but has the benefit of limiting the critical section like in `flocktest2`.

`flocktest4` -- This *looks* like `flocktest0`, but whereas `flocktest0` and all the other ones up until this were using write/exclusive locks, this one is using a read lock, aka a shared lock (`flock -s`). When you run it more than once, none of the instances will block. I don't really know of how this is useful in shell scripting, but it introduces the idea of read / shared locks. Maybe you'll think of a benefit.

`flocktest5` -- This behaves exactly like `flocktest1`, but it's the first example that *doesn't use an external temporary file*. If you've run all the tests up to this point, you'll see a bunch of `flocktest` files in `/tmp/` of your computer. None of the examples cleaned up after themselves. This example doesn't need to, becasue it uses itself as the lock file. This makes for a cleaner implementation in my opinion.

`flocktest6` -- Up until now, every example uses a hardcoded file handle value (8). This example shows how to make the file handle value be a variable. (It's less straightforward than it should be.) Other than that, it works just like the previous example.

`flocktest7` -- Earlier I said `flocktest2` and `flocktest3` had benefit over `flocktest0` and `flocktest1` because they (two and three) have finer control the scope of the critical sections, by using a subshell. Well, that was unfair to zero and one, because they could be modified to explicitly unlock the file. Using a subshell still has the benefit that failing to identify the end of the critical section will trigger a syntax error, whereas you could easily forget to call `flock -u` to unlock the lock.. But subshells cause variable scoping problems, and I now try to avoid them. `flocktest7` is behaviourally the same as `flocktest0`, but also explicitly unlocks the file. (It also doesn't require an external lock file.)
