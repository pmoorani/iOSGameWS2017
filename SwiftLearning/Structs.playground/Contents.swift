//: Playground - noun: a place where people can play

import UIKit

var str = "Structs"

var name = "Ahmad"
var latitude = 41.125
var longitude = 45.111

func getLoc (name : String, lat : Double , long : Double) {
    print(name,latitude,longitude)
}
getLoc(name: name, lat: latitude, long: longitude)

// structures used to group multiple var in one structure
struct userLocation {
    var name : String
    var latitude : Double
    var longitude : Double
}

var myLoc = userLocation(name: "Hussain", latitude: 45.258, longitude: 96.258)

print(myLoc.name)
myLoc.latitude
myLoc.longitude

//function using structures

func Loc(myLocation:userLocation) {
    print(myLocation.name,myLocation.latitude)
}

Loc(myLocation: myLoc)
