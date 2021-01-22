#! /bin/sh
set -x
set -e
###-----------------

FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1                   | head -1);         ### fully qualified argument (path, filename, extension).
FULLY_QUALIFIED__PATH=$(dirname $FULLY_QUALIFIED__PATH_BASE_EXT   | head -1);         ### fully qualified path only.
BASE_EXT=$(basename "$FULLY_QUALIFIED__PATH_BASE_EXT"             | head -1);         ### filename and extension (removing path)
EXT=$(echo "$BASE_EXT" | sed -rn 's#^.*\.([^.]*)$#\1#p'           | head -1);         ### extension extraction. everything after last dot. not including dot.
BASE=$(basename "$BASE_EXT" ".$EXT"                               | head -1);         ### just name (no path, no extension).


rm -f "$FULLY_QUALIFIED__PATH/$BASE_signed.$EXT"

"$JAVA_HOME/bin/zipalign" -v 4 "$FULLY_QUALIFIED__PATH_BASE_EXT" "$FULLY_QUALIFIED__PATH/$BASE_aligned.$EXT"

rm -f "$FULLY_QUALIFIED__PATH_BASE_EXT"

mv --verbose --no-target-directory --force "$FULLY_QUALIFIED__PATH/$BASE_aligned.$EXT" "$FULLY_QUALIFIED__PATH_BASE_EXT"

###-----------------
set +x
set +e

