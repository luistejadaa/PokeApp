//
//  ImageServiceProtocol.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

import UIKit.UIImage

protocol ImageServiceProtocol {
    func getThumbnail(pokemonId: Int, completion: @escaping (UIImage) -> Void)
    func getArtWork(pokemonId: Int, completion: @escaping (UIImage) -> Void)
}
