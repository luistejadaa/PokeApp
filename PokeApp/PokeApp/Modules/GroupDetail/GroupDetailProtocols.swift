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
    static func createModule(region: Region, group: Group) -> UIViewController
    func navigateToPokemonDetail(from: GroupDetailViewProtocol, pokemonId: Int)
    func navigateToEditGroup(from: GroupDetailViewProtocol, region: Region, group: Group)
}

protocol GroupDetailPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: GroupDetailViewProtocol? { get set }
    var interactor: GroupDetailInteractorInputProtocol? { get set }
    var wireFrame: GroupDetailWireFrameProtocol? { get set }
    func getPokemonThumbnail(pokemonId: Int)
    
    func viewDidLoad()
    func getPokemonsCount() -> Int
    func getPokemon(at indexPath: Int) -> PokemonSpecies
    func pushPokemon(at index: Int)
    func pushEditGroup()
}

protocol GroupDetailInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func didReceived(thumbnail: UIImage, for pokemonId: Int)
}

protocol GroupDetailInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: GroupDetailInteractorOutputProtocol? { get set }
    func requestThumbnail(for pokemonId: Int)
}
