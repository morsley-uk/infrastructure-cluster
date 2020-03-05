#!/bin/bash

#set -x

is_numeric () {
  
  if [ "$1" -eq "$1" ] 2>/dev/null; then
    return 1
  fi
  
  return 0
  
}

a=
echo "Is 'a' numeric?"
is_numeric $a
echo $?

b=""
echo "Is 'b' numeric?"
is_numeric $b
echo $?

c="a"
echo "Is 'c' numeric?"
is_numeric $c
echo $?

d="1"
echo "Is 'd' numeric?"
is_numeric $d
echo $?

e=1
echo "Is 'e' numeric?"
is_numeric $e
echo $?

z=1
echo "Is 'z' numeric?"
is_numeric $z

if is_numeric $z; then
    echo "No"
else
    echo "Yes"
fi

set +x

exit 0