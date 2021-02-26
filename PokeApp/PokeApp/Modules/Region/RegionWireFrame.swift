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
    
    func navigateToGroupDetail(from: RegionViewProtocol, region: Region, group: Group) {
        if let viewController = from as? UIViewController {
            viewController.navigationController?.pushViewController(GroupDetailWireFrame.createModule(region: region, group: group), animated: true)
        }
    }
    
    class func createModule(with region: Region) -> UIViewController {
        let view = RegionView()
        let interactor = RegionInteractor()
        let wireFrame = RegionWireFrame()
        let presenter = RegionPresenter(with: region, view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func navigateToCreateGroup(from view: RegionViewProtocol, for region: Region) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(CreateGroupWireFrame.createModule(group: nil, with: region), animated: true)
        }
    }
}
