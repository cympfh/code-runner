{exec} = require 'child_process'
datum = require './datum.json'
fs = require 'fs'

send = (str, cont) ->
  token = "CDR2YBS99ZXWOQSQUERT71KL18ORJV6K"
  url = "https://game.coderunner.jp/q?str=#{str}&token=#{token}"
  exec "curl -s \"#{url}\"", (err, result) ->
    x = +result
    cont x

make = ->
  r = ''
  for i in [0 ... 50]
    c = "ABCD"[Math.random() * 4 | 0]
    r += c
  r

heu = (s) ->
  sum = 0
  for i in [0 .. 45]
    sub = s.slice(i, i+5)
    sum += datum[sub]
  sum

rec = ->
  str = make()
  h = heu str
  send str, (cx) ->
    console.log "\"%s\": %d,", str, cx
    console.log h

do rec

