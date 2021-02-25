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
}

protocol PokemonWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createPokemonModule() -> UIViewController
}

protocol PokemonPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: PokemonViewProtocol? { get set }
    var interactor: PokemonInteractorInputProtocol? { get set }
    var wireFrame: PokemonWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol PokemonInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol PokemonInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: PokemonInteractorOutputProtocol? { get set }
    var remoteDatamanager: PokemonRemoteDataManagerInputProtocol? { get set }
}

protocol PokemonDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol PokemonRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PokemonRemoteDataManagerOutputProtocol? { get set }
}

protocol PokemonRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}
