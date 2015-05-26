//: Playground - noun: a place where people can play

import UIKit

let str = "pxc-egg-beta-dice-chip-free-apple"

let strList = split(str) { $0 == "-" }

var finalList = ""

for s in strList {
    finalList.append(Array(s)[0])
    finalList.append(Array(s)[count(s)-1])
    println(s)
}

println(finalList)