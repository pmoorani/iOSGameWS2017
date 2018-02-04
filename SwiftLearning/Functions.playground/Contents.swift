//: Playground - noun: a place where people can play

import UIKit

var str = "Functions"


//funtions in swift

func firstFunstion() {
    print("hello world")
    print("how are you")

}

firstFunstion()

// func funcName(varName : dataType , varName2 : dataType) {} // without return
func add(num1 : Int, num2 : Int) {
    print(num1 + num2)
}

add(num1: 10, num2: 5)

// func funcName(varName : dataType , varName2 : dataType) -> returnDataType {} // with return datatype

func mul(num1 : Int, num2: Int) -> Int {
    return num1 * num2
}

var num = mul(num1: 5, num2: 4)

print(num)

print(mul(num1: 5, num2: 4))
