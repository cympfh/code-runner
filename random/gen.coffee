{exec} = require 'child_process'

send = (str, cont) ->
  token = "CDR2YBS99ZXWOQSQUERT71KL18ORJV6K"
  url = "https://game.coderunner.jp/q?str=#{str}&token=#{token}"
  exec "curl -s \"#{url}\"", (err, result) ->
    x = +result
    if isNaN x
      console.warn x
    cont x

rec = ->
  r = ''
  chars = "ABCD"
  for i in [0 ... 50]
    r += chars[Math.random() * 4 | 0]
  send r, (x) ->
    console.log r, x if x > 900
    setTimeout rec, 900

do rec
