//
//  Dog.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/7/23.
//

import Foundation

class Dog{
    var name: String
    var personality: String
    var confirmedSighting: Bool = false
    var giveTreat: Bool = false
    
    
    init(named name: String, personality: String) {
        self.name = name
        self.personality = personality
    }
}
