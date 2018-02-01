//: Playground - noun: a place where people can play

import UIKit

var str = "Dictionary"

//exsist as a bunch of info

var myDict = ["blue":"water" , "green":"land"]

myDict["blue"]

myDict["white"] = "peace"

print(myDict)
// optional is a type handle the abbsence of value

print(myDict["blue"]!) //! donate that this key definately have the value for sure
//print(myDict["orange"])

myDict.removeValue(forKey: "blue")
