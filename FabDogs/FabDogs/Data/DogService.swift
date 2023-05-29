//
//  DogService.swift
//  FabDogs
//
//  Created by Maria Gabriela Ayala on 4/7/23.
//

import Foundation

class DogService{
    
    func getDogs() -> [Dog]{
        return [
            Dog(named: "Ramona", personality:"Cute but will fight"),
            Dog(named: "Tomasito", personality:"Lazy and loving"),
            Dog(named: "Federica", personality:"Scaredy and sweet"),
            Dog(named: "Negro", personality:"Loyal and patient"),
            Dog(named: "Manchita", personality:"The cheekiest of all"),
            Dog(named: "Panchita", personality:"My childhood partner"),
            Dog(named: "Mi Amor", personality:"Small but fierce"),
            Dog(named: "Negrita", personality:"Yearning for your love"),
            Dog(named: "Nicky", personality:"Always a good sport"),
            Dog(named: "Uva", personality:"Playful"),
            Dog(named: "Abu", personality:"Stylin'"),
            Dog(named: "Pupi", personality:"Always on the run"),
            Dog(named: "Rufo", personality:"Just chillin'"),
            Dog(named: "Abby", personality:"Miss congeniality"),
            Dog(named: "Barul", personality:"Forever fetching"),
        ]
    }
}
