//
//  HomeInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
    init(remoteDatamanager: HomeRemoteDataManagerInputProtocol) {
        self.remoteDatamanager = remoteDatamanager
    }
    
    func requestRegions() {
        remoteDatamanager?.getRegions()
    }
}

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    func didReceived(_ result: Result<[Region], Error>) {
        switch result {
        case .success(let regions): presenter?.didLoad(regions: regions)
        case .failure(let error): presenter?.didLoad(error: error)
        }
    }
    
    func requestSignOut() {
        UserApp.shared.signOut { (result) in
            if result {
                presenter?.didSignOut()
            } else {
                presenter?.didLoad(error: NSError(domain: "Error", code: -1, userInfo: nil))
            }
        }
    }
}
