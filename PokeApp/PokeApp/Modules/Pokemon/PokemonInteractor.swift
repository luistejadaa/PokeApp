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
    let imageService = ImageService.shared
    let pokemonService = PokemonService.shared
    
    func requestArtImage(for pokemonId: Int) {
        imageService.getArtWork(pokemonId: pokemonId) { (image) in
            self.presenter?.didReceivedArt(image: image)
        }
    }
    
    func requestPokemonDetail(for pokemonId: Int) {
        pokemonService.getPokemon(from: pokemonId) { (result) in
            switch result {
            case .success(let pokemon):
                var detail = [String: String]()
                var name = pokemon.name
                detail["Abilities"] = pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
                detail["Height"] = pokemon.height.description
                detail["Id"] = pokemon.id.description
                detail["Weight"] = pokemon.weight.description
                self.presenter?.didReceivedDetailt(detail, pokemonName: name)
            case .failure(let error): break
            }
        }
    }
}
