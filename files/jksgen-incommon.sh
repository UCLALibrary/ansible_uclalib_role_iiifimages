#! /bin/bash

#
# Script to convert the Let's "Encrypt" output to a Java Keystore
#
#   Usage: ./letsencrypt2jks.sh [DOMAIN] [JKS_PASSWORD]
#

hash openssl 2>/dev/null || { echo >&2 "I require openssl but it's not installed.  Aborting."; exit 1; }

if [ "$#" -ne 2 ]; then
  "Usage: target/letsencrypt2jks.sh [DOMAIN] [PASSWORD]"
fi

# Delete the JKS from our previous run (if it's still around)
sudo rm -f le_jiiify.jks

SSLROOT="/var/local/ssl/$1"

KEYPASS=$2

echo $2

sudo openssl pkcs12 -export \
  -in "$SSLROOT/current-crt" \
  -inkey "$SSLROOT/current-key" \
  -certfile "$SSLROOT/current-chain" \
  -out "/tmp/jiiify_cert_and_key.p12" \
  -password "pass:$KEYPASS"

sudo keytool -importkeystore \
  -srckeystore "/tmp/jiiify_cert_and_key.p12" \
  -srcstoretype "pkcs12" \
  -srcstorepass "$KEYPASS" \
  -destkeystore "le_jiiify.jks" \
  -destkeypass "$KEYPASS" \
  -deststorepass "$KEYPASS" \
  -trustcacerts