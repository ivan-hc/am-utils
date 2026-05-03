#!/bin/sh
rm -rf /opt/bin
mkdir /opt/bin
cd /opt/bin
mv ../*.zip .
unzip *.zip
rm *.zip
cd ..
chmod +x -R bin

