//
//  Region.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

struct Region: Codable {
    let name: String
    let pokedexes: [Pokedex]?
    let url: String!
    
    var regionId: Int? {
        var components = url.components(separatedBy: "/")
        components.removeAll(where: {$0 == ""})
        if let last = components.last, let id  = Int(last) {
            return id
        }
        return nil
    }
}
