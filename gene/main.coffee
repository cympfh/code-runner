{exec} = require 'child_process'
pool = require '../pool.json'
fs = require 'fs'

POOL_SIZE = 20

send = (str, cont) ->
  token = "CDR2YBS99ZXWOQSQUERT71KL18ORJV6K"
  url = "https://game.coderunner.jp/q?str=#{str}&token=#{token}"
  exec "curl -s \"#{url}\"", (err, result) ->
    x = +result
    cont x

select = () ->
  ls = []
  for str of pool
    ls.push {str: str, x: pool[str]}
  I = ls.length
  N = Math.min ls.length, POOL_SIZE
  ls.sort (a, b) -> b.x - a.x
  i = Math.random() * N | 0
  j = Math.random() * N | 0
  if i is j
    select()
  else
    [ls[i], ls[j]]

rand_char = ->
  chars = "ABCD"
  i = Math.random() * 4 | 0
  chars[i]

gen = (pair) ->
  s = pair[0].str
  t = pair[1].str
  ret = ''
  I = s.length

  flg = true
  for i in [0 ... I]
    ret += if flg then s[i] else t[i]
    flg = not flg if Math.random() < 0.9

  ret

rec = ->
  p = select()
  str = gen p
  send str, (cx) ->
    if cx > p[0].cx and cx > p[1].cx
      console.log "\"%s\": %d,", str, cx
      pool[c] = x
      fs.writeFileSync '/tmp/new.json', (JSON.stringify pool)
    else
      console.log "# \"%s\": %d,", str, cx
    setTimeout rec, 998

do rec
