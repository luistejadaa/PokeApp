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

    class func createModule(with region: Region) -> UIViewController {
        let view = CreateGroupView()
        let interactor = CreateGroupInteractor(remoteDatamanager: CreateGroupRemoteDataManager())
        let wireFrame = CreateGroupWireFrame()
        let presenter = CreateGroupPresenter(with: region, view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.remoteDatamanager?.remoteRequestHandler = interactor
        return view
    }
    
}
