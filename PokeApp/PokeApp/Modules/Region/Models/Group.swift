//
//  Group.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

struct Group: Codable {
    let id: Int
    let title: String
    let codeShared: String?
    let pokemons: [Pokemon]
}
