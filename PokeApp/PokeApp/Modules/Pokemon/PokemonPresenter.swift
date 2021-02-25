//
//  PokemonPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation

class PokemonPresenter  {
    
    // MARK: Properties
    weak var view: PokemonViewProtocol?
    var interactor: PokemonInteractorInputProtocol?
    var wireFrame: PokemonWireFrameProtocol?
    
}

extension PokemonPresenter: PokemonPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension PokemonPresenter: PokemonInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
