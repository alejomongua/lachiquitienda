window.indexedDB = window.indexedDB || window.webkitIndexedDB || window.mozIndexedDB;

if ('webkitIndexedDB' in window) 
  window.IDBTransaction = window.webkitIDBTransaction
  window.IDBKeyRange = window.webkitIDBKeyRange

LACh = {}
LACh.IDB = {}
LACh.IDB.db = null

window.___gcfg = lang: "es-419"
(->
  po = document.createElement("script")
  po.type = "text/javascript"
  po.async = true
  po.src = "https://apis.google.com/js/plusone.js"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore po, s
)()

_gaq = _gaq or []
_gaq.push ["_setAccount", "UA-xxxxxxxx-X"]
_gaq.push ["_trackPageview"]
(->
  ga = document.createElement("script")
  ga.type = "text/javascript"
  ga.async = true
  ga.src = ((if "https:" is document.location.protocol then "https://ssl" else "http://www")) + ".google-analytics.com/ga.js"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore ga, s
)()

not ((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  unless d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//platform.twitter.com/widgets.js"
    fjs.parentNode.insertBefore js, fjs
)(document, "script", "twitter-wjs")

((d, buildThese) ->
  homeScript = undefined
  newScript = undefined
  n = buildThese.length
  i = undefined
  i = 0
  while i < n
    newScript = d.createElement("SCRIPT")
    newScript.type = "text/javascript"
    newScript.async = true
    newScript.src = buildThese[i]
    homeScript = d.getElementsByTagName("SCRIPT")[0]
    homeScript.parentNode.insertBefore newScript, homeScript
    i = i + 1
) document, ["//assets.pinterest.com/js/pinit.js"]

Number::formatMoney = (c, d, t) ->
  n = this
  c = (if isNaN(c = Math.abs(c)) then 2 else c)
  d = (if d is `undefined` then "," else d)
  t = (if t is `undefined` then "." else t)
  s = (if n < 0 then "-" else "")
  i = parseInt(n = Math.abs(+n or 0).toFixed(c)) + ""
  j = (if (j = i.length) > 3 then j % 3 else 0)
  "$" + s + ((if j then i.substr(0, j) + t else "")) + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + ((if c then d + Math.abs(n - i).toFixed(c).slice(2) else ""))