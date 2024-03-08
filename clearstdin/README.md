I write a lot of automation scripts, like to create backups of important files, or to check the temperature
before adjusting a heater. I use them to perform tasks that are complex and/or that I don't want to do 
manually, and, crucially, which don't need human input. I would use shell script for this purpose, wouldn't you?

I only have a couple tasks that are complicated enough that I would like to automate, but which still need
my input before the task can be completed. Such as organizing a folder full of various types of image or
audio media. I want something to go through each file, analyze it in some way or other, then offer to move
it to a final destination. But I need to be involved with the final decision, either approving the suggested
disposition, or overriding it. So these are semi-automated scripts.

I still want to use a shell script to do this. That's cool, as a shell script can prompt a user and `read` 
in the user's response. But, shell scripts have pretty big input buffers. So something that gets typed by the user will be buffered until it's read. So if during a long-running operations during my script's execution, a cat walks across my keyboard, or I idly hit enter a few times, I might accidentally answer or accept the next suggested value before I even get a chance to see what the prompt said! 

So for long runing semi-automated scripts, I need a way to clear out the input buffer before the script prompts me for in the next item. Enter clearstdin. 

```
clearstdin() {
	while read -r -t 0; do read -n 256 -r; done
}
```

This bash function, when called, will eat up and harmless dispose of any data in the input buffer. The script in this folder shows it in action.
