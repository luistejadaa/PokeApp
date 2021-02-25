//
//  RegionServiceProtocol.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

protocol RegionServiceProtocol: class {
    func getRegions(completion: @escaping (Result<[Region], Error>) -> Void)
    func getRegion(_ regionName: String, completion: @escaping (Result<Region, Error>) -> Void)
}
