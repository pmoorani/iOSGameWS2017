//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// for loop in swift start point eg 1 ... 10 (ending point)
// take all the numbers from starting to ending point included

for num in 1...10{
    print(num)
}

for items in 10...20 {
    print(items)
}

// stride function tell you starting point and ending point and what are we skiping in the loop e.g printint even number

for num in stride(from: 0, to: 10, by: 3){
    print(num)
}

// for in array
var shoppinglist = ["Apples","bananas","oranges"]

for value in shoppinglist{
    print(value)
}
//for in dictionary
var legend = ["blue":"ocean","green":"land"]
for item in legend{
    print(item)
    //just getting the value
    print(item.value)
    //just getting the key in dictiionary
    print(item.key)
}
//enumarated function to getting index in arrays
for (index, value) in shoppinglist.enumerated(){
    if index != 0{
        print(index)
        print(value)
    }
}
