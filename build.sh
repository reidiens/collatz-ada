#!/bin/bash

src="src/main.adb"

gnatmake -eS src/*.adb

if [ "$?" -ne 0 ]; then 
    if [ "$?" -eq 127 ]; then
        echo "gnatmake not installed"
        echo " "
        echo "Please install gnatmake manually or through your distro's"
        echo "package manager"

        exit $? 
    fi
    exit $? 
fi


gnatmake -eS ${src} -o collatz

if [ "$?" -ne 0 ]; then
    exit $?;
fi

mv collatz ${HOME}/.bin/

rm *.ali *.o