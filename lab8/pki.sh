#!/bin/bash

openssl x509 -in 194_TURKTRUST_Elektronik_Sertifika_Hizmet_Saglayicisi_h7.crt -noout -text > realroot.txt

openssl req -newkey rsa:4096 -keyout acme.key -out acme.csr -nodes -subj "/C=US/ST=CALIFORNIA/O=ACME/CN=Acme Corporation"

mkdir -p demoCA
touch demoCA/index.txt
echo 01 > demoCA/serial
mkdir -p demoCA/newcerts

openssl ca -selfsign -in acme.csr -out acme.pem -keyfile acme.key -days 3650 -batch

openssl req -new -newkey rsa:4096 -nodes -keyout bob.key -out bob.csr -subj "/C=US/ST=CALIFORNIA/O=ACME/CN=Bob"

openssl ca -in bob.csr -out BOB.pem -cert acme.pem -keyfile acme.key -days 3650 -batch

