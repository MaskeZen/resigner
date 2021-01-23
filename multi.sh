#! /bin/sh
set -x
set -e
###-----------------

###
###this needs gnu parallel: run 'apt-get -y install parallel', optionally run 'parallel --citation' and type 'will cite' to remove the text-banner.
###

FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1 | head -1);         ### fully qualified argument (path, filename, extension).
FULLY_QUALIFIED__SELF_PATH=$(dirname $0         | head -1);         ### fully qualified path only, of this script. this will be used to build an explicit target for other scripts in this folder since the '$0' and '.' context - will change from within parallel or other commands.
FULLY_QUALIFIED__RESIGN_SH="$FULLY_QUALIFIED__SELF_PATH/resign.sh"; ### fully qualified path to './resign.sh'

###find . -name "*.zip" -name "*.jar" -name "*.apk" -exec ls -la {} ";"

###find . -type f -name '*.zip' -name '*.jar' -name '*.apk' -print0 | parallel -0 unzip -d {/.} {}

find "$FULLY_QUALIFIED__PATH_BASE_EXT" -type f \( -name "*.zip" -o -name "*.jar" -o -prune -name "_original_*" \) -print0 | parallel -0 "$FULLY_QUALIFIED__RESIGN_SH" {}

##find "$FULLY_QUALIFIED__PATH_BASE_EXT" -type f \( -name "*.zip" -o -name "*.jar" -o -prune -name "_original_*" \) -print0 | parallel -0 ls {}
