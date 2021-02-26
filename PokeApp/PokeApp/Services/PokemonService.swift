//
//  PokemonService.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

final class PokemonService: PokemonServiceProtocol {
    
    static let shared: PokemonService = {
        let instance = PokemonService()
        return instance
    }()
    
    let directlyPokemon = "https://pokeapi.co/api/v2/pokemon/"
    let apiManager = APIManager.shared
    func getPokemon(from pokemonId: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        print(pokemonId)
        apiManager.getWithoutPagination(url: "\(directlyPokemon)/\(pokemonId)") { (result: Result<Pokemon, Error>) in
            switch result {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
