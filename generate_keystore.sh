#! /bin/sh
set +x
set +e
#--------------------------------------------------------------------------------------------

FULLY_QUALIFIED__SELF_PATH=$(dirname $0         | head -1);         ### fully qualified path only, of this script. this will be used to build an

rm -f "$FULLY_QUALIFIED__SELF_PATH/foo.keystore"


###keytool -genkeypair                                     \
###        -alias      "alias_name"                        \
###        -keyalg     "RSA"                               \
###        -keysize    "2048"                              \
###        -sigalg     "SHA1withRSA"                       \
###        -validity   "10000"                             \
###        -keypass    "111111"                            \
###        -keystore   "$FULLY_QUALIFIED__SELF_PATH/foo.keystore"                    \
###        -storepass  "111111"                            \
###        -dname      'CN=*, OU=*, O=*, L=*, S=*, C=*'    \
###        -v


keytool -genkeypair                                     \
        -alias      "alias_name"                        \
        -keyalg     "RSA"                               \
        -keysize    "2048"                              \
        -sigalg     "SHA1withRSA"                       \
        -validity   "10000"                             \
        -keypass    "111111"                            \
        -keystore   "$FULLY_QUALIFIED__SELF_PATH/foo.keystore"                    \
        -storepass  "111111"                            \
        -dname      'CN=*, OU=*, O=*, L=*, S=*, C=*'


