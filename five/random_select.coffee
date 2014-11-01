{exec} = require 'child_process'
datum = require './datum.json'
fs = require 'fs'

send = (str, cont) ->
  token = "CDR2YBS99ZXWOQSQUERT71KL18ORJV6K"
  url = "https://game.coderunner.jp/q?str=#{str}&token=#{token}"
  exec "curl -s \"#{url}\"", (err, result) ->
    x = +result
    cont x

ls = []
for s of datum
  ls.push { str: s, cx: datum[s] }
ls.sort (a, b) -> b.cx - a.cx

sum = 0
for o in ls
  sum += o.cx

rand = ->
  x = Math.random() * sum
  for o in ls
    x -= o.cx
    if x < 0
      return o
  ls[ls.length - 1]

rec = ->
  str = ''
  for idx in [0 ... 10]
    str += rand().str
  send str, (cx) ->
    console.log "# \"%s\": %d,", str, cx
    setTimeout rec, 900

do rec
