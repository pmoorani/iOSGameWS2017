//: Playground - noun: a place where people can play

import UIKit

var str = "Inheritance, Overloading"

class Parent {
    func parentMethod(){
        print("this is a parent method")
    }
    func getName(){
        print("this is parent")
    }
}

var p = Parent()
p.parentMethod()

class Child : Parent{
    func childMethod(){
        print("this is a child method")
    }
    //overriding
    override func getName() {
        print("this is child")
    }
}
var c = Child()
c.childMethod()
c.parentMethod()
c.getName()
