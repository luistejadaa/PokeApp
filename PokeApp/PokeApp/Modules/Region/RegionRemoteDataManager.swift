//
//  RegionRemoteDataManager.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

final class RegionRemoteDataManager: RegionRemoteDataManagerInputProtocol {
    var remoteRequestHandler: RegionRemoteDataManagerOutputProtocol?
    let service = GroupService.shared
    func getGroups(forRegionId: Int) {
        service.getGroups(forRegionId: forRegionId) { (result) in
            switch result {
            case .success(let groups):
                self.remoteRequestHandler?.didReceived(data: groups)
            case .failure(let error):
                self.remoteRequestHandler?.didReceived(error: error)
            }
        }
    }
}
