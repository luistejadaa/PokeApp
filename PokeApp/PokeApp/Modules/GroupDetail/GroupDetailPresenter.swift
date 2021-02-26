//
//  GroupDetailPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import UIKit.UIImage

class GroupDetailPresenter {
    // MARK: Properties
    weak var view: GroupDetailViewProtocol?
    var interactor: GroupDetailInteractorInputProtocol?
    var wireFrame: GroupDetailWireFrameProtocol?
    var speciesList: [PokemonSpecies]!
    var groupName: String!
    
    init(species: [PokemonSpecies], view: GroupDetailViewProtocol, interactor: GroupDetailInteractorInputProtocol, wireFrame: GroupDetailWireFrameProtocol, groupName: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.speciesList = species
        self.groupName = groupName
    }
}

extension GroupDetailPresenter: GroupDetailPresenterProtocol {
    func pushPokemon(at index: Int) {
        wireFrame?.navigateToPokemonDetail(from: view!, pokemonId: speciesList[index].species.pokemonId!)
    }
    
    func getPokemonThumbnail(pokemonId: Int) {
        interactor?.requestThumbnail(for: pokemonId)
    }
    func getPokemonsCount() -> Int {
        return speciesList.count
    }
    
    func getPokemon(at indexPath: Int) -> PokemonSpecies {
        return speciesList[indexPath]
    }
    
    func viewDidLoad() {
        view?.updateTitle(title: groupName)
    }
}

extension GroupDetailPresenter: GroupDetailInteractorOutputProtocol {
    func didReceived(thumbnail: UIImage, for pokemonId: Int) {
        if let index = speciesList.firstIndex(where: {$0.species.pokemonId == pokemonId}) {
            speciesList[index].image = thumbnail
            view?.reloadCell(at: index)
        }
    }
}
