//
//  GroupDetailProtocols.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

protocol GroupDetailViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: GroupDetailPresenterProtocol? { get set }
    func reloadData()
    func reloadCell(at index: Int)
    func displayError(_ error: Error)
    func updateTitle(title: String)
}

protocol GroupDetailWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule(groupName: String, species: [PokemonSpecies]) -> UIViewController
}

protocol GroupDetailPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: GroupDetailViewProtocol? { get set }
    var interactor: GroupDetailInteractorInputProtocol? { get set }
    var wireFrame: GroupDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getPokemonsCount() -> Int
    func getPokemon(at indexPath: Int) -> Pokemon
}

protocol GroupDetailInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func loadPokemon(_ pokemon: Pokemon)
    func loadError(_ error: Error)
}

protocol GroupDetailInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: GroupDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: GroupDetailRemoteDataManagerInputProtocol? { get set }
    func getPokemons(species: [PokemonSpecies])
}

protocol GroupDetailDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol GroupDetailRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: GroupDetailRemoteDataManagerOutputProtocol? { get set }
    func requestPokemons(from species: [PokemonSpecies])
}

protocol GroupDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func receivedPokemon(_ pokemon: Pokemon)
    func receivedError(_ error: Error)
}
