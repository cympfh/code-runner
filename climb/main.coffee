{exec} = require 'child_process'
pool = require '../pool.json'
fs = require 'fs'

send = (str, cont) ->
  token = "CDR2YBS99ZXWOQSQUERT71KL18ORJV6K"
  url = "https://game.coderunner.jp/q?str=#{str}&token=#{token}"
  exec "curl -s \"#{url}\"", (err, result) ->
    x = +result
    cont x

ls = []
for s of pool
  ls.push {str: s, cx: pool[s]}
ls.sort (a, b) -> b.cx - a.cx
idx = Math.random() * ls.length / 30 | 0
str = ls[idx].str
cx = pool[str]

console.warn str, pool[str]

rchar = ->
  g = "ABCD"
  g[Math.random() * 4 | 0]

pr = 0.5

cli = ->
  ls = str.split ''
  idx = Math.random() * str.length | 0
  ls[idx] = rchar()
  next = ls.join ''

  send next, (x) ->
    console.log "\"%s\": %d,", next, x
    if cx < x
      cx = x
      str = next
      pr = 0.5

    setTimeout cli, 991

do cli
