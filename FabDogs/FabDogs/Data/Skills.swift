//
//  Skills.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 5/18/23.
//

import Foundation

class Skills {
    
    var name: String
    var shortDesc: String
    var description: String
    var imageUrl: String
        
    init(named name: String, shortDesc:String, description: String, imageUrl: String) {
        self.name = name
        self.shortDesc = shortDesc
        self.description = description
        self.imageUrl = imageUrl
    }
}
