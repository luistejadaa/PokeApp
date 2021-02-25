//
//  GroupDetailPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation

class GroupDetailPresenter  {
    
    // MARK: Properties
    weak var view: GroupDetailViewProtocol?
    var interactor: GroupDetailInteractorInputProtocol?
    var wireFrame: GroupDetailWireFrameProtocol?
    
    var pokemons: [Pokemon]!
    var species: [PokemonSpecies]!
    var groupName: String!
    
    init(species: [PokemonSpecies], view: GroupDetailViewProtocol, interactor: GroupDetailInteractorInputProtocol, wireFrame: GroupDetailWireFrameProtocol, groupName: String) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.species = species
        self.groupName = groupName
    }
}

extension GroupDetailPresenter: GroupDetailPresenterProtocol {
    
    func getPokemonsCount() -> Int {
        return pokemons.count
    }
    
    func getPokemon(at indexPath: Int) -> Pokemon {
        return pokemons[indexPath]
    }
    
    func viewDidLoad() {
        pokemons = [Pokemon]()
        interactor?.getPokemons(species: species)
        view?.updateTitle(title: groupName)
    }
}

extension GroupDetailPresenter: GroupDetailInteractorOutputProtocol {
    func loadError(_ error: Error) {
        view?.displayError(error)
    }
    
    func loadPokemon(_ pokemon: Pokemon) {
        pokemons.append(pokemon)
        view?.reloadData()
    }
}
