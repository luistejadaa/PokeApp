//
//  RegionInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

class RegionInteractor: RegionInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: RegionInteractorOutputProtocol?
    var remoteDatamanager: RegionRemoteDataManagerInputProtocol?
    
    init(remoteDatamanager: RegionRemoteDataManagerInputProtocol) {
        self.remoteDatamanager = remoteDatamanager
    }
}

extension RegionInteractor: RegionRemoteDataManagerOutputProtocol {
}
