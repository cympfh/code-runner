#!/bin/bash

str=DAAABACBABAAADCCCDACDDADABDDAADCABDBDDDDADDADBDAAD
token=CDR2YBS99ZXWOQSQUERT71KL18ORJV6K
URL="https://game.coderunner.jp/q?str=${str}&token=${token}"

echo "#" $str
curl $URL
sleep 1
