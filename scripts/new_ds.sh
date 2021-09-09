#!/bin/bash

NAME="$1"

if [[ -z $NAME ]] ; then
    echo "You must pass the name of the data structure to this script"
    exit 1
fi

DIR=`dirname $0`/../structs/$NAME

if [[ -d $DIR ]] ; then
    echo "A structure called $NAME already exists"
    exit 1
fi

mkdir $DIR

GUARD="_${NAME^^}_H_GUARD_"

cat Makefile-for-ds | sed "s/{INSERT_DS_NAME_HERE}/$NAME/g" > $DIR/Makefile
echo -n -e "#include \"$NAME.h\"\n\n" > $DIR/$NAME.c
echo -n -e "#ifndef $GUARD\n#define $GUARD\n\n\n\n#endif" > $DIR/$NAME.h