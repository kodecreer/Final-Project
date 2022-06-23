# Final-Project
This is my final project for C-Arch

This is a program that is a choose your own adventure based on the Lord of the Rings Khazad Dum. You must enter into the correct values to make choices that advance you into the game. It either has yes or no prompts or there is a range of numbers you have to select from.  The program only has play again if you win because only winners get the reward in this game. It uses an std.s file for some helper subroutines that makes the project a lot easier. Mostly the getchar and the print subroutines. The main has two subroutines for printing out error messages when a value isn’t validated properly.  One for when it’s a number option and another when we mess up on a simple yes or no question. I have included the doc files for each subroutine separately or one in a complete file for the std.s library I made for whatever your preference is. 

There are different endings to the game, but many ways to fail. I fixed a lot of the broken labels from what was shown in the demonstration. I created a compile.sh file to compile all the source code only without running it. I also included an update.sh which runs the latest version of the program that is retrieved from the git repository it’s stored in. 

This is a very very large program mostly because there are so many scenarios and choices and I wanted to take the opportunity to better learn how to program large stuff more efficiently. This is something I will need outside of this class. Some of the things learned are obviously keeping the requirements as simple as possible. It also brings a lot of appreciation for the work done in C and C++ who had to write those languages from scratch in Assembly. 

Check the source code if you want to see where the options lead and it is very large program so feel free if there is anything wrong. 

The way you run the program from the .sh files is simply by executing the shell script
sh compile.sh ;this one just compiles it and you have to execute it yourself by simply
./main ;entering that command to run it

sh update.sh ; this one retrieves the latest source code and then executes it. I suggest not working from this unless if you cloned the repository

