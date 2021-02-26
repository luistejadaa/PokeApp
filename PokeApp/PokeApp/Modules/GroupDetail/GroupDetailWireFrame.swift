//
//  GroupDetailWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

class GroupDetailWireFrame: GroupDetailWireFrameProtocol {

    func navigateToEditGroup(from: GroupDetailViewProtocol, region: Region, group: Group) {
        var delegate: CreateGroupDelegate?
        if let createGroupDelegate = from.presenter?.interactor as? CreateGroupDelegate {
            delegate = createGroupDelegate
        }
        if let viewController = from as? UIViewController {
            let module = CreateGroupWireFrame.createModule(group: group, with: region, delegate: delegate)
            viewController.navigationController?.pushViewController(module, animated: true)
        }
    }
    
    class func createModule(region: Region, group: Group) -> UIViewController {
        let view = GroupDetailView()
        let interactor = GroupDetailInteractor()
        let wireFrame = GroupDetailWireFrame()
        let presenter = GroupDetailPresenter(region: region, group: group, view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func navigateToPokemonDetail(from: GroupDetailViewProtocol, pokemonId: Int) {
        if let viewController = from as? UIViewController {
            viewController.navigationController?.pushViewController(PokemonWireFrame.createModule(pokemonId: pokemonId), animated: true)
        }
    }
}
