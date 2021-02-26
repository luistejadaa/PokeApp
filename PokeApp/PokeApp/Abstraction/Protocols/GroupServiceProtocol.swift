//
//  GroupServiceProtocol.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

protocol GroupServiceProtocol: class {
    func getGroups(forRegionId: Int, completion: @escaping (Result<[[String: AnyObject]], Error>) -> Void)
    func saveGroup(group: Group, completion: @escaping (Error?) -> Void)
    func removeGroup(group: Group, completion: @escaping (Error?) -> Void)
}
