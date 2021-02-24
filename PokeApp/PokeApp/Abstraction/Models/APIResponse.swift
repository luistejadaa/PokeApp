//
//  APIResponse.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//
import Foundation

struct APIResponse<T>: Codable where T: Codable {
    
    let count: Int!
    let next: String?
    let previous: String?
    let results: [T]?
}
