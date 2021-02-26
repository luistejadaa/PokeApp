//
//  PokemonProtocols.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

protocol PokemonViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: PokemonPresenterProtocol? { get set }
    func updateArt(image: UIImage)
    func reloadData()
}

protocol PokemonWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule(pokemonId: Int) -> UIViewController
}

protocol PokemonPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: PokemonViewProtocol? { get set }
    var interactor: PokemonInteractorInputProtocol? { get set }
    var wireFrame: PokemonWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getDetailCount() -> Int
    func getDetail(at index: Int) -> (title: String, description: String)?
    func getPokemonName() -> String?
}

protocol PokemonInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func didReceivedArt(image: UIImage)
    func didReceivedDetailt(_ detail: [String: String], pokemonName: String)
}

protocol PokemonInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: PokemonInteractorOutputProtocol? { get set }
    func requestArtImage(for pokemonId: Int)
    func requestPokemonDetail(for pokemonId: Int)
}

protocol PokemonDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
    func getArtImage(pokemonId: Int)
    func getPokemonDetail(pokemonId: Int)
}
