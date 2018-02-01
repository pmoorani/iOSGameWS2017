//: Playground - noun: a place where people can play

import UIKit

var str = "Arrays"

var shoppinglist = ["apples","oranges","grapes"]

print(shoppinglist[0])
print(shoppinglist[1])
print(shoppinglist[2])

//adding new values
shoppinglist.append("milk")
shoppinglist

shoppinglist.count

shoppinglist.first
shoppinglist.last
shoppinglist.remove(at: 0)
print(shoppinglist)
shoppinglist.removeAll()
//empty array

var newArr = [Int]()
newArr.append(5)
newArr.append(6)
print(newArr)
newArr[1] = 50
print(newArr)

