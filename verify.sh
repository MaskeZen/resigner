#! /bin/sh
set -x
set -e
###-----------------

FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1 | head -1);

"$JAVA_HOME/bin/jarsigner" -verify "-verbose:all" -certs "-strict" "$FULLY_QUALIFIED__PATH_BASE_EXT"

###-----------------
set +x
set +e

