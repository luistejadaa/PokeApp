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
    let groupService = GroupService.shared
    func requestGroups(forRegionId: Int) {
        groupService.getGroups(forRegionId: forRegionId) { (result) in
            switch result {
            case .success(let groups):
                if let jsonData = try? JSONSerialization.data(withJSONObject: groups, options: .fragmentsAllowed) {
                    if let groups = try? JSONDecoder().decode([Group].self, from: jsonData) {
                        self.presenter?.didLoad(groups: groups)
                    }
                }
            case .failure(let error):
                self.presenter?.didLoad(error: error)
            }
        }
    }
}
