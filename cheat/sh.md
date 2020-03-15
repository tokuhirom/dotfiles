# use strict

    shopt -s -o nounset

# autodie

    set -e

# verbose

    set -x

# check argumetn

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
    echo "Usage: $0 DIRECTORY" >&2
    exit 1
fi

# To implement a for loop:
for file in *;
do
    echo $file found;
done

# To implement a case command:
case "$1"
in
    0) echo "zero found";;
    1) echo "one found";;
    2) echo "two found";;
    3*) echo "something beginning with 3 found";;
esac

# $FindBin::Bin

DIR=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
