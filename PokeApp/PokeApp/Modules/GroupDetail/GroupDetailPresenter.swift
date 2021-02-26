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
    var group: Group!
    var region: Region!
    
    init(region: Region, group: Group, view: GroupDetailViewProtocol, interactor: GroupDetailInteractorInputProtocol, wireFrame: GroupDetailWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.group = group
        self.region = region
    }
}

extension GroupDetailPresenter: GroupDetailPresenterProtocol {
    
    func pushEditGroup() {
        wireFrame?.navigateToEditGroup(from: view!, region: region, group: group)
    }
    
    func pushPokemon(at index: Int) {
        wireFrame?.navigateToPokemonDetail(from: view!, pokemonId: group.pokemons[index].species.pokemonId!)
    }
    
    func getPokemonThumbnail(pokemonId: Int) {
        interactor?.requestThumbnail(for: pokemonId)
    }
    func getPokemonsCount() -> Int {
        return group.pokemons.count
    }
    
    func getPokemon(at indexPath: Int) -> PokemonSpecies {
        return group.pokemons[indexPath]
    }
    
    func viewDidLoad() {
        view?.updateTitle(title: group.name)
    }
}

extension GroupDetailPresenter: GroupDetailInteractorOutputProtocol {
    func didReceived(thumbnail: UIImage, for pokemonId: Int) {
        if let index = group.pokemons.firstIndex(where: {$0.species.pokemonId == pokemonId}) {
            group.pokemons[index].image = thumbnail
            view?.reloadCell(at: index)
        }
    }
}
