#! /bin/sh
set -x
set -e
###-----------------


FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1                   | head -1);         ### fully qualified argument (path, filename, extension).
FULLY_QUALIFIED__PATH=$(dirname $FULLY_QUALIFIED__PATH_BASE_EXT   | head -1);         ### fully qualified path only.
BASE_EXT=$(basename "$FULLY_QUALIFIED__PATH_BASE_EXT"             | head -1);         ### filename and extension (removing path)
EXT=$(echo "$BASE_EXT" | sed -rn 's#^.*\.([^.]*)$#\1#p'           | head -1);         ### extension extraction. everything after last dot. not including dot.
BASE=$(basename "$BASE_EXT" ".$EXT"                               | head -1);         ### just name (no path, no extension).




rm -rf "$FULLY_QUALIFIED__PATH/$BASE/"                                                ### pre-cleanup (old sessions?)
7z x "$FULLY_QUALIFIED__PATH_BASE_EXT" -o"$FULLY_QUALIFIED__PATH/$BASE/";             ### extract content from archive, into a newly created folder in the given path.

mkdir -p "$FULLY_QUALIFIED__PATH/$BASE/META-INF/";                                    ### make sure sub-folder is there.
cd "$FULLY_QUALIFIED__PATH/$BASE/META-INF/"                                           ### prepare to clean 'META-INF' old-content but keeping some stuff.

###-----------------------------------------------------------------------------------### remove certificates and checksums, keep other stuff ('Manifest-Version: 1.0', 'Created-By: 1.8.0_151 (Oracle Corporation)', 'Main-Class: input2stdout' - for example).
rm -f *.RSA *.SF;


sed -i -r '/^Name:/d'    "./MANIFEST.MF"  #lines starting with 'Name:'
sed -i -r '/^SHA/d'      "./MANIFEST.MF"  #lines starting with 'SHA'
sed -i -r '/Digest:/d'   "./MANIFEST.MF"  #lines with 'Digest:'
 
sed -i -r '/^\s*$/d'     "./MANIFEST.MF"  #empty-lines.
dos2unix "./MANIFEST.MF"                  #to linux-EOL (\n).
sed -i -r 's#\n$\n$#\n#' "./MANIFEST.MF"  #empty lines.
echo "" >>"./MANIFEST.MF"                 #add one empty line at the end.
unix2dos "./MANIFEST.MF"                  #to Windows-EOL (\r\n).


###-----------------------------------------------------------------------------------###

cd "$FULLY_QUALIFIED__PATH/$BASE/"
####-ssw

mv --verbose --no-target-directory --force "$FULLY_QUALIFIED__PATH_BASE_EXT" "$FULLY_QUALIFIED__PATH/_original__$BASE_EXT"

7z a -tzip -y -mmt4 -mx9 -mem=ZipCrypto -mm=Deflate "$FULLY_QUALIFIED__PATH/$BASE.zip" '*'

mv --verbose --no-target-directory --force "$FULLY_QUALIFIED__PATH/$BASE.zip" "$FULLY_QUALIFIED__PATH/$BASE.$EXT"

rm -fr "$FULLY_QUALIFIED__PATH/$BASE/"


###-----------------
set +x
set +e

