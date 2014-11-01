#!/bin/bash

for str in `cat list`; do
  token=CDR2YBS99ZXWOQSQUERT71KL18ORJV6K
  URL="https://game.coderunner.jp/q?str=${str}&token=${token}"

  RESULT=`curl -s $URL`
  echo $str : $RESULT
  sleep 1
done
