#! /bin/sh
set +x
set +e
###-----------------


FULLY_QUALIFIED__PATH_BASE_EXT=$(readlink -f $1                   | head -1);         ### fully qualified argument (path, filename, extension).
FULLY_QUALIFIED__PATH=$(dirname $FULLY_QUALIFIED__PATH_BASE_EXT   | head -1);         ### fully qualified path only.
BASE_EXT=$(basename "$FULLY_QUALIFIED__PATH_BASE_EXT"             | head -1);         ### filename and extension (removing path)
EXT=$(echo "$BASE_EXT" | sed -rn 's#^.*\.([^.]*)$#\1#p'           | head -1);         ### extension extraction. everything after last dot. not including dot.
BASE=$(basename "$BASE_EXT" ".$EXT"                               | head -1);         ### just name (no path, no extension).



cd "$FULLY_QUALIFIED__PATH";
pwd

rm -rf "./_tmp_$BASE_EXT/";                                                ### pre-cleanup (old sessions?)
7z x -y "./$BASE_EXT" -o"./_tmp_$BASE_EXT/";             ### extract content from archive, into a newly created folder in the given path.

cd "./_tmp_$BASE_EXT/";
pwd

mkdir -p "META-INF";                                    ### make sure sub-folder is there.
cd "./META-INF/";                                           ### prepare to clean 'META-INF' old-content but keeping some stuff.
pwd

###-----------------------------------------------------------------------------------### remove certificates and checksums, keep other stuff ('Manifest-Version: 1.0', 'Created-By: 1.8.0_151 (Oracle Corporation)', 'Main-Class: input2stdout' - for example).
rm -f *.RSA *.SF;

##-----------------------------------only work on MANIFEST.MF if there is any, and avoiding creating a blank one with 'touch MANIFEST.MF' - it is bad since the jarsigner will not write headers such 'Created-By', etc.. - if there is an empty file already, it will just write file checksums, it will probably work, but it does not look as nice.
if [ -f "./MANIFEST.MF" ]; then
  sed -i -r '/^Name:/d'                "./MANIFEST.MF";  #lines starting with 'Name:'
  sed -i -r '/^SHA/d'                  "./MANIFEST.MF";  #lines starting with 'SHA'
  sed -i -r '/Digest:/d'               "./MANIFEST.MF";  #lines with 'Digest:'
   
  sed -i -r '/^\s*$/d'                 "./MANIFEST.MF";  #empty-lines.
  dos2unix "./MANIFEST.MF";                              #unify to linux-EOL (\n) so the following regular-expressions will be simpler.
  sed -i -r 's#\s*\n\s*$\s*\n\s*$#\n#' "./MANIFEST.MF";  #empty lines.
  sed -i -r '/\s*\n\s*$/d'             "./MANIFEST.MF";  #empty-lines.
  
  ##-----------------------------------------------------it is best to remove an empty MANIFEST.MF file, jarsigner will recreate it (an empty 'META-INF/' folder is fine though.
  if [ -s "./MANIFEST.MF" ]; then
    rm -f "./MANIFEST.MF";
  else
    unix2dos "./MANIFEST.MF";                              #unify to Windows-EOL (\r\n) to be readable in Windows, and Windows-compiled binaries.
  fi
fi

###-----------------------------------------------------------------------------------###

cd ../../
pwd

####-ssw

mv --verbose --no-target-directory --force "./$BASE_EXT" "./_original__$BASE_EXT"

cd "./_tmp_$BASE_EXT/";
pwd

7z a -tzip -y -mmt4 -mx9 -mem=ZipCrypto -mm=Deflate "-x!./$BASE.$EXT" "./$BASE.$EXT" '*'

##mv --verbose --no-target-directory --force "./$BASE.zip" "./$BASE.$EXT"

mv --verbose --force "./$BASE.$EXT" "../";

cd "../";
pwd

rm -fr "./_tmp_$BASE_EXT/";


