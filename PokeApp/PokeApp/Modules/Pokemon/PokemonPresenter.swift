//
//  PokemonPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import UIKit.UIImage

final class PokemonPresenter {
    
    // MARK: Properties
    weak var view: PokemonViewProtocol?
    var interactor: PokemonInteractorInputProtocol?
    var wireFrame: PokemonWireFrameProtocol?
    var pokemonId: Int!
    var pokemonArtImage: UIImage?
    var pokemonDetail: [(String, String)]?
    var pokemonName: String?
    
    init(view: PokemonViewProtocol, interactor: PokemonInteractorInputProtocol, wireFrame: PokemonWireFrameProtocol, pokemonId: Int) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.pokemonId = pokemonId
    }
}

extension PokemonPresenter: PokemonPresenterProtocol {
    func getPokemonName() -> String? {
        return pokemonName
    }
    
    func getDetail(at index: Int) -> (title: String, description: String)? {
        if let detail = pokemonDetail {
            return detail[index]
        }
        return nil
    }
    
    func getDetailCount() -> Int {
        return pokemonDetail?.count ?? 0
    }

    func viewDidLoad() {
        interactor?.requestArtImage(for: pokemonId)
        interactor?.requestPokemonDetail(for: pokemonId)
    }
}

extension PokemonPresenter: PokemonInteractorOutputProtocol {

    func didReceivedArt(image: UIImage) {
        pokemonArtImage = image
        view?.updateArt(image: image)
    }
    
    func didReceivedDetailt(_ detail: [String: String], pokemonName: String) {
        pokemonDetail = detail.map({(title: $0, description: $1)}).sorted(by: {$0.title < $01.title})
        self.pokemonName = pokemonName
        view?.reloadData()
    }
}
