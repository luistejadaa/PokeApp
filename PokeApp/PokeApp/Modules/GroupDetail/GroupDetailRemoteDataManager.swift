//
//  GroupDetailRemoteDataManager.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation

class GroupDetailRemoteDataManager: GroupDetailRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: GroupDetailRemoteDataManagerOutputProtocol?
    let service = PokemonService.shared
    func requestPokemons(from species: [PokemonSpecies]) {
        for spec in species {
            service.getPokemon(from: spec.species.url) { (result) in
                switch result{
                case .success(let pokemon):
                    self.remoteRequestHandler?.receivedPokemon(pokemon)
                case .failure(let error):
                    self.remoteRequestHandler?.receivedError(error)
                }
            }
        }
    }
}
