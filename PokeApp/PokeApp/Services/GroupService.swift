//
//  GroupService.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

class GroupService: GroupServiceProtocol {
    static let shared: GroupService = {
        let instance = GroupService()
        return instance
    }()
    let database = RealtimeManager.shared
    var apiManager: APIManager = .shared
    var groupPath = "Group"
    func getGroups(forRegionId: Int, completion: @escaping (Result<[[String: AnyObject]], Error>) -> Void) {
        if let userId = UserApp.shared.userId {
            database.getChilds(path: "users/\(userId)/groups/\(forRegionId)") { (result) in
                switch result {
                case .success(let dicts):
                    completion(.success(dicts))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func saveGroup(group: Group, completion: @escaping (Error?) -> Void) {
        if let userId = UserApp.shared.userId {
            database.writeChild(path: "users/\(userId)/groups/\(group.regionId!)/", values: group) { (error) in
                completion(error)
            }
        }
    }
}
