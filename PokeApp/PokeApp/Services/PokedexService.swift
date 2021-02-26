//
//  PokedexService.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

final class PokedexService: PokedexServiceProtocol {
    
    static let shared: PokedexService = {
        let instance = PokedexService()
        return instance
    }()
    private let apiManager = APIManager.shared
    private let regionService = RegionService.shared
    func getPokedex(for regionName: String, completion: @escaping (Result<[Pokedex], Error>) -> Void) {
        regionService.getRegion(regionName) { (regionResult) in
            switch regionResult {
            case .success(let region):
                var pokedexesResult = [Pokedex]()
                if let pokedexes = region.pokedexes {
                    for index in 0..<pokedexes.count {
                        if let url = pokedexes[index].url {
                            self.apiManager.getWithoutPagination(url: url) { (pokedexResult: Result<Pokedex, Error>) in
                                switch pokedexResult {
                                case .success(let pokedex):
                                    pokedexesResult.append(pokedex)
                                    if index == pokedexes.count - 1 {
                                        completion(.success([pokedexesResult[0]]))
                                    }
                                case .failure(let error): completion(.failure(error))
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
