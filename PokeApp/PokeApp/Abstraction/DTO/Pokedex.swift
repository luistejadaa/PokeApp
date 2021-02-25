//
//  Pokedex.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.

// MARK: - Pokedex
import UIKit.UIImage

struct Pokedex: Codable {
    let id: Int?
    let name: String
    let url: String?
    var pokemons: [PokemonSpecies]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, url, pokemons = "pokemon_entries"
    }
}

struct PokemonSpecies: Codable {
    let species: Species
    var image: UIImage?
    private enum CodingKeys: String, CodingKey {
        case species = "pokemon_species"
    }
}

struct Species: Codable {
    let name: String
    let url: String
    
    var pokemonId: Int? {
        var components = url.components(separatedBy: "/")
        components.removeAll(where: {$0 == ""})
        if let last = components.last, let id  = Int(last) {
            return id
        }
        return nil
    }
}
