//
//  RegionInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

final class RegionInteractor: RegionInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: RegionInteractorOutputProtocol?
    var remoteDatamanager: RegionRemoteDataManagerInputProtocol?
    
    init(remoteDatamanager: RegionRemoteDataManagerInputProtocol) {
        self.remoteDatamanager = remoteDatamanager
    }
    
    func requestGroups(forRegionId: Int) {
        remoteDatamanager?.getGroups(forRegionId: forRegionId)
    }
}

extension RegionInteractor: RegionRemoteDataManagerOutputProtocol {
    func didReceived(error: Error) {
        
    }
    func didReceived(data: [[String: AnyObject]]) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed) {
            if let groups = try? JSONDecoder().decode([Group].self, from: jsonData) {
                self.presenter?.didLoad(groups: groups)
            }
        }
    }
}
