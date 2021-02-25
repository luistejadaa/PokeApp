//
//  HomeRemoteDataManager.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

class HomeRemoteDataManager: HomeRemoteDataManagerInputProtocol {
    
    var service = RegionService.shared
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?

    func getRegions() {
        service.getRegions { (result) in
            self.remoteRequestHandler?.didReceived(result)
        }
    }
}
