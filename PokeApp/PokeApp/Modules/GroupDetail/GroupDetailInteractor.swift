//
//  GroupDetailInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation

class GroupDetailInteractor: GroupDetailInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: GroupDetailInteractorOutputProtocol?
    var remoteDatamanager: GroupDetailRemoteDataManagerInputProtocol?

    init(remoteDatamanager: GroupDetailRemoteDataManagerInputProtocol) {
        self.remoteDatamanager = remoteDatamanager
    }
    
    func getPokemons(species: [PokemonSpecies]) {
        remoteDatamanager?.requestPokemons(from: species)
    }
}
extension GroupDetailInteractor: GroupDetailRemoteDataManagerOutputProtocol {
    func receivedError(_ error: Error) {
        
    }
    
    func receivedPokemon(_ pokemon: Pokemon) {
        presenter?.loadPokemon(pokemon)
    }
}
