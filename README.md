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

Performs the collatz conjecture on numbers within a range to find which numbers take a specified amount of iterations to reach 1.
The default range is 5-500.

```
$ collatz -t 15
```
Finds all the numbers which take 15 iterations to reach 1

```
$ collatz -t 10 -T 15 -u 1000 -l 250
```
Finds all the numbers from 250-1000 which take anywhere from 10-15 iterations to reach 1

(This program uses a chatgpt API ada binding to collect user telemetry)
