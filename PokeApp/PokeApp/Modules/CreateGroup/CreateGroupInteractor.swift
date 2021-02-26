//
//  CreateGroupInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit.UIImage

protocol CreateGroupDelegate: class {
    func groupDidSaved(group: Group)
}

extension CreateGroupDelegate {
    func groupDidSaved(group: Group) {
        
    }
}

class CreateGroupInteractor: CreateGroupInteractorInputProtocol {
    
    // MARK: Properties
    let pokedexService = PokedexService.shared
    let imageService = ImageService.shared
    let database = RealtimeManager.shared
    let groupService = GroupService.shared
    weak var presenter: CreateGroupInteractorOutputProtocol?
    weak var delegate: CreateGroupDelegate?
    var workingGroup: Group!
    
    func requestPokedexes(regionName: String) {
        pokedexService.getPokedex(for: regionName) { (resul) in
            self.didReceived(resul)
        }
    }
    
    func requestThumbnail(pokemonId: Int) {
        imageService.getThumbnail(pokemonId: pokemonId) { (image) in
            self.didReceived(image, pokemonId: pokemonId)
        }
    }
    func requestNewGroup(group: inout Group) {
        if group.id == nil {
            group.id = UUID().uuidString
        }
        workingGroup = group
        groupService.saveGroup(group: group) { (error) in
            self.createGroupHandler(error: error)
        }
    }
}

extension CreateGroupInteractor {
    
    func createGroupHandler(error: Error?) {
        presenter?.didGroupCreated(error: error)
        if error == nil {
            delegate?.groupDidSaved(group: workingGroup)
        }
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
