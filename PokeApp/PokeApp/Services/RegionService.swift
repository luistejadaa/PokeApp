//
//  RegionService.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

class RegionService: RegionServiceProtocol {
    
    static let shared: RegionService = {
        let instance = RegionService()
        return instance
    }()
    var apiManager: APIManager = .shared
    var regionPath = "region"
    func getRegions(completion: @escaping (Result<[Region], Error>) -> Void) {
        apiManager.getWithPagination(path: regionPath, queryItems: []) { (apiResponse: Result<APIResponse<Region>, Error>) in
            switch apiResponse {
            case.success(let response): completion(.success(response.results))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
