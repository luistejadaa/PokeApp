//
//  HomeRemoteDataManager.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

class HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    var service: RegionServiceProtocol = RegionService.shared
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?

    func getRegions() {
        service.getRegions { [self] (result) in
            remoteRequestHandler?.didReceived(result)
        }
    }
}
