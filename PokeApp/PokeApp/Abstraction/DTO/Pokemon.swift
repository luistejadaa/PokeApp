//
//  Pokemon.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import UIKit.UIImage

struct Pokemon: Codable {
    let id: Int!
    let name: String!
    let types: [Type]?
    var thumbnail: UIImage?
    private enum CodingKeys: String, CodingKey {
        case id, name, types
    }
    
}

struct Type: Codable {
    let slot: Int!
    let type: TypeDetail!
}

struct TypeDetail: Codable {
    let name: String!
    let url: String!
}
