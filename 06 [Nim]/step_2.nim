import tables
import os
import streams
import strutils

let arguments = commandLineParams()
let fname = arguments[0]

var stream = newFileStream(fname)
let firstLine = stream.readLine()
let length = firstLine.len() - 1
stream.setPosition(0)
var resultArray = newTable[int, CountTable[char]]()

for i in 0..length:
  resultArray[i] = initCountTable[char]()

while not stream.atEnd:
  let line = stream.readLine()
  for i, c in line:
    resultArray[i].inc(c)

var result = "";
for i in 0..length:
  resultArray[i].sort # not sure why it's needed, but does not work without it
  result = result & resultArray[i].smallest().key

echo result

stream.close()
