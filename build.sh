#!/bin/bash

src=$1
link=${src%.*}.ali

gcc -c ${src}

if [ "$?" -ne 0 ]; then 
    exit 1
fi

gnatbind -x ${link}

if [ "$?" -ne 0 ]; then
    exit 2
fi

gnatlink ${link}

if [ "$?" -ne 0 ]; then
    exit 3
fi

rm *.ali *.o