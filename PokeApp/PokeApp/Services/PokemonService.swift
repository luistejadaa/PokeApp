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
    
    let apiManager = APIManager.shared
    func getPokemon(from url: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        apiManager.getWithoutPagination(url: url) { (result: Result<Pokemon, Error>) in
            switch result {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
