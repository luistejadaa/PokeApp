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
        if let viewController = from as? UIViewController {
            viewController.navigationController?.pushViewController(CreateGroupWireFrame.createModule(group: group, with: region), animated: true)
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
