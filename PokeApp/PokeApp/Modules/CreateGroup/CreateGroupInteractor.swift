//
//  CreateGroupInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit.UIImage

class CreateGroupInteractor: CreateGroupInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: CreateGroupInteractorOutputProtocol?
    var remoteDatamanager: CreateGroupRemoteDataManagerInputProtocol?
    
    init(remoteDatamanager: CreateGroupRemoteDataManagerInputProtocol) {
        self.remoteDatamanager = remoteDatamanager
    }
    
    func requestPokedexes(regionName: String) {
        remoteDatamanager?.getPokemons(for: regionName)
    }
    
    func requestThumbnail(pokemonId: Int) {
        remoteDatamanager?.getThumbnail(pokemonId: pokemonId)
    }
    func requestNewGroup(group: inout Group) {
        if group.id == nil {
            group.id = UUID().uuidString
        }
        remoteDatamanager?.createGroup(group: group)
    }
}

extension CreateGroupInteractor: CreateGroupRemoteDataManagerOutputProtocol {
    
    func createGroupHandler(error: Error?) {
        presenter?.didGroupCreated(error: error)
    }
    
    func didReceived(_ image: UIImage, pokemonId: Int) {
        presenter?.didLoad(image: image, pokemonId: pokemonId)
    }
    
    func didReceived(_ result: Result<[Pokedex], Error>) {
        switch result {
        case .success(let pokedexes):
            presenter?.didLoad(pokedexes: pokedexes)
        case .failure(let error):
            presenter?.didLoad(error: error)
        }
    }
}
