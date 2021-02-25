//
//  PokemonInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation

class PokemonInteractor: PokemonInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: PokemonInteractorOutputProtocol?
    var remoteDatamanager: PokemonRemoteDataManagerInputProtocol?

}

extension PokemonInteractor: PokemonRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
