//
//  PokemonWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

class PokemonWireFrame: PokemonWireFrameProtocol {
    
    class func createModule(pokemonId: Int) -> UIViewController {
        let view = PokemonView()
        let interactor = PokemonInteractor()
        let wireFrame = PokemonWireFrame()
        let presenter = PokemonPresenter(view: view, interactor: interactor, wireFrame: wireFrame, pokemonId: pokemonId)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
