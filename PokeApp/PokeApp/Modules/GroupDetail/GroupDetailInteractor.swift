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
    var imageService = ImageService.shared
    
    func requestThumbnail(for pokemonId: Int) {
        imageService.getThumbnail(pokemonId: pokemonId) { (image) in
            self.presenter?.didReceived(thumbnail: image, for: pokemonId)
        }
    }
}
