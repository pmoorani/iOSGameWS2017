//: Playground - noun: a place where people can play

import UIKit

var str = "Classes, Objects"

// making a Class

class Person {
    //properties
    var name : String
    var age : Int
    //behaviours
    init(name : String , age : Int) {
        self.name = name
        self.age = age
    }
    func greeting(){
        // to avoid concatination we can use \(variableName)
        print("your name is  \(self.name) and your age is : \(self.age)")
    }
}

//creating object from Person class
var person1 = Person(name : "Ahmad" , age : 21)
person1.age
person1.name

person1.greeting()
