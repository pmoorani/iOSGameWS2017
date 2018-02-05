//: Playground - noun: a place where people can play

import UIKit

var str = "switch and loop statements"

var age = 18

switch age {
case 16:
    print("you are 16")
case 18:
    print("you are 18")
default:
    print("i am not sure how old you are")
}

//loop control statement

for i in 1...5 {
    print(i)
    if i == 2 {
        break
    }
}

for i in 1...10 {
    for j in 1...5 {
        if j == 3 {
            break
        }
        print(j)
    }
    print(i)
}

for i in 1...5 {
    if i == 3 {
        continue
    }
    print(i)
}
