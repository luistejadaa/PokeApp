//
//  Group.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Firebase

struct Group: Codable {
    var id: String!
    var regionId: Int!
    var name: String!
    var codeShared: String?
    var pokemons: [PokemonSpecies]!
}
