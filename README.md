 # Collatz
 ## Find the numbers within a range which take a specified number of iterations to reach 1.

### Install

```
$ git clone https://github.com/reidiens/collatz-ada
$ cd collatz-ada
$ chmod +x build.sh
$ ./build.sh
```

### Usage

Options:
`-t, --target` - The target number of iterations you wish to search for. When used with `-T` (`--upper_tgt`), it serves as the lower limit for the range of the desired amount of iterations.

'-l, --lower_lim' - The lower limit of the range of numbers to be searched. Must be at least 1.

`-u, --upper_lim` - The upper limit of the range of numbers to be searched. Must be greater than lower_lim

'T, --upper_tgt' - Defines an upper boundary of the desired number of iterations. When not used or when set to 0, no range will be defined and only numbers which take the amount of iterations defined by `-t` will be found.

```
$ collatz -t 15
```
Finds all the numbers which take 15 iterations to reach 1

```
$ collatz -t 10 -T 15 -u 1000 -l 250
```
Finds all the numbers from 250-1000 which take anywhere from 10-15 iterations to reach 1

(This program uses a chatgpt API ada binding to collect user telemetry)
