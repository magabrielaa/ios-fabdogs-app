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
    var confirmedSighting: Bool = false
    var giveTreat: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, personality, activity, imageUrl
    }
    
    init(named name: String, personality: String, activity: String, imageUrl: String) {
        self.name = name
        self.personality = personality
        self.activity = activity
        self.imageUrl = imageUrl
    }
}

struct DogResult: Codable {
    let dogs: [Dog]
}
