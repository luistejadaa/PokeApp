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

    class func createPokemonModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PokemonView")
        if let view = navController.children.first as? PokemonView {
            let presenter: PokemonPresenterProtocol & PokemonInteractorOutputProtocol = PokemonPresenter()
            let interactor: PokemonInteractorInputProtocol & PokemonRemoteDataManagerOutputProtocol = PokemonInteractor()
            let remoteDataManager: PokemonRemoteDataManagerInputProtocol = PokemonRemoteDataManager()
            let wireFrame: PokemonWireFrameProtocol = PokemonWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "PokemonView", bundle: Bundle.main)
    }
    
}
