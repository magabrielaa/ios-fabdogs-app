//
//  Dog.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/7/23.
//

import Foundation

class Dog: CustomDebugStringConvertible, Codable {
    var debugDescription: String {
        return "Dog(name: \(self.name), personality: \(self.personality), isFavorite: \(self.isFavorite)"
    }
    var name: String
    var personality: String
    var ability: String?
    var imageUrl: String
    var origin: String
    var lat: Double
    var lon: Double
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, personality, ability, imageUrl, origin, lat, lon
    }
    
    init(named name: String, personality: String, ability: String, imageUrl: String, origin:String, lat:Double, lon:Double) {
        self.name = name
        self.personality = personality
        self.ability = ability
        self.imageUrl = imageUrl
        self.origin = origin
        self.lat = lat
        self.lon = lon
    }
}

struct DogResult: Codable {
    let dogs: [Dog]
}
