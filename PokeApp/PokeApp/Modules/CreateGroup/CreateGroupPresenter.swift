//
//  CreateGroupPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import UIKit.UIImage

final class CreateGroupPresenter {
    
    // MARK: Properties
    weak var view: CreateGroupViewProtocol?
    var interactor: CreateGroupInteractorInputProtocol?
    var wireFrame: CreateGroupWireFrameProtocol?
    var pokedexes: [Pokedex]!
    var region: Region!
    var pokemons: [PokemonSpecies]!
    
    init(with region: Region, view: CreateGroupViewProtocol, interactor: CreateGroupInteractorInputProtocol, wireFrame: CreateGroupWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.region = region
        pokemons = [PokemonSpecies]()
    }
}

extension CreateGroupPresenter: CreateGroupPresenterProtocol {
    
    func pushPokemon(at indexPath: IndexPath) {
        if let id = pokedexes[indexPath.section].pokemons?[indexPath.row].species.pokemonId {
            wireFrame?.navigateToPokemonDetail(from: view!, pokemonId: id)
        }
    }
    
    func saveGroup(name: String) {
        if pokemons.count >= 3 {
            interactor?.requestNewGroup(pokemons: pokemons, name: name, regionId: region.regionId!)
        } else {
            view?.displayError(NSError(domain: "You cannot add less than three Pokémon", code: 0, userInfo: nil))
        }
    }
    
    func getPokemonSpecies(at indexPath: IndexPath) -> PokemonSpecies? {
        if let pokemon = pokedexes[indexPath.section].pokemons?[indexPath.row] {
            return pokemon
        }
        return nil
    }
    
    func addPokemon(at indexPath: IndexPath) {
        if pokemons.count < 6 {
            if let pokemon = pokedexes[indexPath.section].pokemons?[indexPath.row] {
                pokemons.append(pokemon)
            }
        } else {
            view?.displayError(NSError(domain: "You cannot add more than six Pokémon", code: 0, userInfo: nil))
        }
        view?.reloadCell(at: indexPath)
    }
    
    func removePokemon(at indexPath: IndexPath) {
        if let pokemon = pokedexes[indexPath.section].pokemons?[indexPath.row] {
            pokemons.removeAll(where: {$0.species.pokemonId == pokemon.species.pokemonId})
            view?.reloadCell(at: indexPath)
        }
    }
    
    func checkIfPokemonIsAdded(at indexPath: IndexPath) -> Bool {
        if let pokemon = pokedexes[indexPath.section].pokemons?[indexPath.row] {
            return pokemons.contains(where: {$0.species.pokemonId == pokemon.species.pokemonId})
        }
        return false
    }
    
    func getPokemonThumbnail(for indexPath: IndexPath) {
        if let id = pokedexes[indexPath.section].pokemons![indexPath.row].species.pokemonId {
            interactor?.requestThumbnail(pokemonId: id)
        }
    }
    
    func viewDidLoad() {
        interactor?.requestPokedexes(regionName: region.name)
    }
    
    func getPokedexCount() -> Int {
        return pokedexes?.count ?? 0
    }
    
    func getPokemonCount(forPokedex: Int) -> Int {
        return pokedexes?[forPokedex].pokemons?.count ?? 0
    }
    
    func getPokemonName(at index: Int, forPokedex: Int) -> String? {
        return pokedexes?[forPokedex].pokemons?[index].species.name
    }
    
    func getPokedexName(at index: Int) -> String? {
        return pokedexes?[index].name
    }
}

extension CreateGroupPresenter: CreateGroupInteractorOutputProtocol {
    func didGroupCreated(error: Error?) {
        if let error = error {
            view?.displayError(error)
        } else {
            view?.groupCreated(message: "Group was created")
        }
    }
    
    func didLoad(image: UIImage, pokemonId: Int) {
        for section in 0..<pokedexes.count {
            if let row = pokedexes[section].pokemons?.firstIndex(where: {$0.species.pokemonId == pokemonId}) {
                self.pokedexes[section].pokemons![row].image = image
                if let view = view {
                    view.reloadCell(at: IndexPath(row: row, section: section))
                }
            }
        }
    }
    
    func didLoad(pokedexes: [Pokedex]) {
        self.pokedexes = pokedexes
        view?.reloadData()
    }
    
    func didLoad(error: Error) {
        view?.displayError(error)
    }

}
