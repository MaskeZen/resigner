#! /bin/sh
set -x
set -e
#--------------------------------------------------------------------------------------------

rm -f "./foo.keystore"

$JAVA_HOME/bin/keytool  -genkeypair                                     \
                        -alias      "alias_name"                        \
                        -keyalg     "RSA"                               \
                        -keysize    "2048"                              \
                        -sigalg     "SHA1withRSA"                       \
                        -validity   "10000"                             \
                        -keypass    "111111"                            \
                        -keystore   "./foo.keystore"                    \
                        -storepass  "111111"                            \
                        -dname      'CN=*, OU=*, O=*, L=*, S=*, C=*'     \
                        -v

#--------------------------------------------------------------------------------------------
set +x
set +e

