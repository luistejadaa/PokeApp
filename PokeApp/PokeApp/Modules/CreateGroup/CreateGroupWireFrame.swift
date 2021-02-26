//
//  CreateGroupWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class CreateGroupWireFrame: CreateGroupWireFrameProtocol {
    
    func navigateToPokemonDetail(from: CreateGroupViewProtocol, pokemonId: Int) {
        if let viewController = from as? UIViewController {
            viewController.navigationController?.pushViewController(PokemonWireFrame.createModule(pokemonId: pokemonId), animated: true)
        }
    }
    
    class func createModule(group: Group?, with region: Region, delegate: CreateGroupDelegate?) -> UIViewController {
        let view = CreateGroupView()
        let interactor = CreateGroupInteractor()
        let wireFrame = CreateGroupWireFrame()
        let presenter = CreateGroupPresenter(with: region, group: group, view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.delegate = delegate
        return view
    }
    
}
