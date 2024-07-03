 # Collatz
 ## Find the numbers within a range which take a specified number of iterations to reach 1.

### Install

```
$ git clone https://github.com/reidiens/collatz-ada
$ cd collatz-ada
$ chmod +x build.sh
$ ./build.sh
```
If it fails, make sure you have gnatmake installed. Feel free to modify the build script to your liking. Or compile it all manually, whatever feels best. The executable is placed in ~/.bin by default.

### Usage

Options:
 - `-t, --target` - The target number of iterations you wish to search for. When used with `-T` (`--upper_tgt`), it serves as the lower limit for the range of the desired amount of iterations.

 - `-l, --lower_lim` - The lower limit of the range of numbers to be searched. Must be at least 1.

 - `-u, --upper_lim` - The upper limit of the range of numbers to be searched. Must be greater than lower_lim

 - `-T, --upper_tgt` - Defines an upper boundary of the desired number of iterations. When not used or when set to 0, no range will be defined and only numbers which take the amount of iterations defined by `-t` will be found.

 - `-f, --first` - Only shows the first number found instead of all of them

#### Examples:
```
$ collatz -t 15
```
Finds all the numbers which take 15 iterations to reach 1

```
$ collatz -t 10 -T 15 -u 1000 -l 250
```
Finds all the numbers from 250-1000 which take anywhere from 10-15 iterations to reach 1

```
$ collatz --first --target=89 --lower_lim=250 --upper_lim=2500
```
Finds the first number in the range 250-2500 to take 89 iterations to reach 1
