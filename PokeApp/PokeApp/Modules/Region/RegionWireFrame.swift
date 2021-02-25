//
//  RegionWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class RegionWireFrame: RegionWireFrameProtocol {
    
    func navigateToGroupDetail(from: RegionViewProtocol, _ species: [PokemonSpecies], groupName: String) {
        if let viewController = from as? UIViewController {
            viewController.navigationController?.pushViewController(GroupDetailWireFrame.createModule(groupName: groupName, species: species), animated: true)
        }
    }
    
    class func createModule(with region: Region) -> UIViewController {
        let view = RegionView()
        let interactor = RegionInteractor(remoteDatamanager: RegionRemoteDataManager())
        let wireFrame = RegionWireFrame()
        let presenter = RegionPresenter(with: region, view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.remoteDatamanager?.remoteRequestHandler = interactor
        return view
    }
    
    func navigateToCreateGroup(from view: RegionViewProtocol, for region: Region) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(CreateGroupWireFrame.createModule(with: region), animated: true)
        }
    }
}
