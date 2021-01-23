#! /bin/sh
set +x
set +e
###-----------------

FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1 | head -1);


###jarsigner -verify "-verbose:all" -certs "$FULLY_QUALIFIED__PATH_BASE_EXT"
jarsigner -verify "$FULLY_QUALIFIED__PATH_BASE_EXT"

###zipalign -c -v 4 "$FULLY_QUALIFIED__PATH_BASE_EXT"
zipalign -c 4 "$FULLY_QUALIFIED__PATH_BASE_EXT"

