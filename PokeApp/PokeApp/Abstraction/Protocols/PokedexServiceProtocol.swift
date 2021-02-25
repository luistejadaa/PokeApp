//
//  PokedexServiceProtocol.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

protocol PokedexServiceProtocol: class {
    func getPokedex(for regionName: String, completion: @escaping (Result<[Pokedex], Error>) -> Void)
}
