//
//  Pokemon.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import UIKit.UIImage

import Foundation

// MARK: - Welcome
struct Pokemon: Codable {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let name: String
    let weight: Int
}

struct Ability: Codable {
    let ability: AbilityDetail

    private enum CodingKeys: String, CodingKey {
        case ability
    }
}
struct AbilityDetail: Codable {
    let name: String
    let url: String
}
