//
//  Dog.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/7/23.
//

import Foundation

class Dog: CustomDebugStringConvertible, Codable {
    var debugDescription: String {
        return "Dog(name: \(self.name), personality: \(self.personality))"
    }
    var name: String
    var personality: String
    var activity: String?
    var imageUrl: String
    var breed: String
    var origin: String
    var lat: Double
    var lon: Double
    var confirmedSighting: Bool = false
    var giveTreat: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, personality, activity, imageUrl, breed, origin, lat, lon
    }
    
    init(named name: String, personality: String, activity: String, imageUrl: String, breed:String, origin:String, lat:Double, lon:Double) {
        self.name = name
        self.personality = personality
        self.activity = activity
        self.imageUrl = imageUrl
        self.breed = breed
        self.origin = origin
        self.lat = lat
        self.lon = lon
    }
}

struct DogResult: Codable {
    let dogs: [Dog]
}
