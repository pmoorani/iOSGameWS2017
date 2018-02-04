//: Playground - noun: a place where people can play

import UIKit

var str = "Enumerations or Enums"

// used to clasify data

enum Direction {
    case North
    case South
    case West
    case East
}

var dir = Direction.North
// swtich must implemented all enum cases but it dont have dafalut case in enum
switch dir {
case Direction.North:
    print("Go Forward")
case Direction.South:
    print("GO Backword")
case .East:
    print("Take a Right")
case .West:
    print("Take a Left")
}
//raw value in enum
enum DirectionRaw : String {
    case North = "Go Forward"
    case South = "Go Backword"
    case West  = "Take a Right"
    case East  = "Take a Left"
}

var dirRaw = DirectionRaw.South
    dirRaw.hashValue
    dirRaw.rawValue

//use enum when yu have set number of options
