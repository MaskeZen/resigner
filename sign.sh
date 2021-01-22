#! /bin/sh
set -x
set -e
###-----------------

FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1 | head -1);

if [ ! -f "./foo.keystore" ]; then
  "./generate_keystore.sh"
fi

"$JAVA_HOME/bin/jarsigner" -keystore "./foo.keystore" -storepass "111111" -keypass "111111" -digestalg "SHA1" -sigalg "SHA1withRSA" "-verbose:all" -strict "$FULLY_QUALIFIED__PATH_BASE_EXT" "alias_name"

###-----------------
set +x
set +e

