//
//  CreateGroupRemoteDataManager.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

final class CreateGroupRemoteDataManager:CreateGroupRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: CreateGroupRemoteDataManagerOutputProtocol?
    let pokedexService = PokedexService.shared
    let imageService = ImageService.shared
    let database = RealtimeManager.shared
    let groupService = GroupService.shared
    func getPokemons(for regionName: String) {
        pokedexService.getPokedex(for: regionName) { (resul) in
            self.remoteRequestHandler?.didReceived(resul)
        }
    }
    
    func getThumbnail(pokemonId: Int) {
        imageService.getThumbnail(pokemonId: pokemonId) { (image) in
            self.remoteRequestHandler?.didReceived(image, pokemonId: pokemonId)
        }
    }
    
    func createGroup(group: Group) {
        groupService.saveGroup(group: group) { (error) in
            self.remoteRequestHandler?.createGroupHandler(error: error)
        }
    }
}
