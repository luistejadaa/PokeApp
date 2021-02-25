//
//  GroupService.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation

class GroupService: GroupServiceProtocol {
    
    typealias GroupType = Group
    static let shared: GroupService = {
        let instance = GroupService()
        return instance
    }()
    var apiManager: APIManager = .shared
    var groupPath = "Group"
    func getGroups(completion: @escaping (Result<[GroupType], Error>) -> Void) {
        
    }
}
