//
//  RegionDetail.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

// MARK: - RegionDetal
struct RegionDetal: Codable {
    let id: Int
    let name: String
    let pokedexes: [Pokedex]
}
