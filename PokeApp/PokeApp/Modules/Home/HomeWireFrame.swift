//
//  HomeWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class HomeWireFrame: HomeWireFrameProtocol {
    
    class func createModule() -> UIViewController {
        let view = HomeView()
        let interactor = HomeInteractor(remoteDatamanager: HomeRemoteDataManager())
        let wireFrame = HomeWireFrame()
        let presenter = HomePresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.remoteDatamanager?.remoteRequestHandler = interactor
        return view
    }
    
    func navigateToLogin() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let loginModule = LoginWireFrame.createModule()
            appDelegate.changeRootController(by: loginModule)
        }
    }
}
