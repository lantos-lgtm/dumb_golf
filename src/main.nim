# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import random
import benchy
import unittest


# if statements
func calcPercentIf(num: float): string =
  if num == 0.0:
    return "0000000000"
  if num > 0.0 and num <= 0.1:
    return "X000000000"
  if num > 0.1 and num <= 0.2:
    return "XX00000000"
  if num > 0.2 and num <= 0.3:
    return "XXX0000000"
  if num > 0.3 and num <= 0.4:
    return "XXXX000000"
  if num > 0.4 and num <= 0.5:
    return "XXXXX00000"
  if num > 0.5 and num <= 0.6:
    return "XXXXXX0000"
  if num > 0.6 and num <= 0.7:
    return "XXXXXXX000"
  if num > 0.7 and num <= 0.8:
    return "XXXXXXXX00"
  if num > 0.8 and num <= 0.9:
    return "XXXXXXXXX0"
  return "XXXXXXXXXX"


# 0.1 => int(10/10) = 1
func calcPercentMath(num: float): string = 
  result = "0000000000"
  if num > 1.0:
    return "XXXXXXXXXX"
  for i in 0..<int(num*10):
    result[i] = 'X'


const percentConstants = [
  "0000000000",
  "X000000000",
  "XX00000000",
  "XXX0000000",
  "XXXX000000",
  "XXXXX00000",
  "XXXXXX0000",
  "XXXXXXX000",
  "XXXXXXXX00",
  "XXXXXXXXX0",
]

func calcPercentMathConst(num: float): string = 
  if num >= 1.0:
    return "XXXXXXXXXX"
  return percentConstants[int(num*10)]

func calcPercentMathConstPtr(num: float): ptr string =
  return percentConstants[int(num * 10)].unsafeAddr

suite "test":
  test "calcPercentIf":
    check: calcPercentIf(0.0) == "0000000000"
    check: calcPercentIf(0.1) == "X000000000"
    check: calcPercentIf(0.2) == "XX00000000"
    check: calcPercentIf(1.0) == "XXXXXXXXXX"
  test "calcPercentMath":
    check: calcPercentMath(0.0) == "0000000000"
    check: calcPercentMath(0.1) == "X000000000"
    check: calcPercentMath(0.2) == "XX00000000"
    check: calcPercentMath(1.0) == "XXXXXXXXXX"

when isMainModule:
  const runs = 10
  const counts = 10_000_000
  randomize()
  timeIt("if", runs):
    for i in 0..counts:
      keep calcPercentIf(rand(0.0..1.0))

  timeit("math", runs):
    for i in 0..counts:
      keep calcPercentMath(rand(0.0..1.0))

  timeit("mathConst", runs):
    for i in 0..counts:
      keep calcPercentMathConst(rand(0.0..1.0))

  timeit("mathConstPtr", runs):
    for i in 0..counts:
      keep calcPercentMathConstPtr(rand(0.0..1.0))[]
  
