#! /bin/sh
set +x
set +e
###-----------------

FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1 | head -1);
FULLY_QUALIFIED__SELF_PATH=$(dirname $0         | head -1);

if [ ! -f "$FULLY_QUALIFIED__SELF_PATH/foo.keystore" ]; then
  "$FULLY_QUALIFIED__SELF_PATH/generate_keystore.sh"
fi

####"$JAVA_HOME/bin/

jarsigner -keystore "$FULLY_QUALIFIED__SELF_PATH/foo.keystore" -storepass "111111" -keypass "111111" -digestalg "SHA1" -sigalg "SHA1withRSA" "-verbose:all" "$FULLY_QUALIFIED__PATH_BASE_EXT" "alias_name"

