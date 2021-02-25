//
//  ImageService.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//

import UIKit.UIImage

final class ImageService: ImageServiceProtocol {
    
    static let shared: ImageService = {
        let instance = ImageService()
        return instance
    }()
    
    let apiManager = APIManager.shared
    func getThumbnail(pokemonId: Int, completion: @escaping (UIImage) -> Void) {
        apiManager.getImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png") { (image) in
            completion(image)
        }
    }
    func getArtWork(pokemonId: Int, completion: @escaping (UIImage) -> Void) {
        apiManager.getImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png") { (image) in
            completion(image)
        }
    }
}
