window.indexedDB = window.indexedDB || window.webkitIndexedDB || window.mozIndexedDB;

if ('webkitIndexedDB' in window) 
  window.IDBTransaction = window.webkitIDBTransaction
  window.IDBKeyRange = window.webkitIDBKeyRange

LACh = {}
LACh.IDB = {}
LACh.IDB.db = null