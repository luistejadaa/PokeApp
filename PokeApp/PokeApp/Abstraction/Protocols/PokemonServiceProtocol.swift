//
//  PokemonServiceProtocol.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

protocol PokemonServiceProtocol {
    func getPokemon(from url: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
}
