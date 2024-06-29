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

gnatmake -eS ${src}

if [ "$?" -ne 0 ]; then
    exit $?;
fi

mv main ${HOME}/.bin/collatz

rm *.ali *.o
