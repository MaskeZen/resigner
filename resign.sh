#! /bin/sh

./clear_signature.sh "$1"   2>/dev/null;

./sign.sh "$1"              2>/dev/null;

./align.sh "$1"             2>/dev/null;

./verify.sh "$1"            2>/dev/null;

