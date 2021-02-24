//
//  RegionServiceProtocol.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//

protocol RegionServiceProtocol: class {
    func getRegions(completion: @escaping (Result<[Region], Error>) -> Void)
}
