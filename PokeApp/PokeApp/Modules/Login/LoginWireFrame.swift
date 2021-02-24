//
//  LoginWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//  
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {

    class func createModule() -> UIViewController {
        let view = LoginView()
        let interactor = LoginInteractor()
        let wireFrame = LoginWireFrame()
        let presenter = LoginPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        UserApp.shared.delegate = interactor
        return view
    }
    
    func navigateToHome() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let homeModule = HomeWireFrame.createModule()
            appDelegate.changeRootController(by: UINavigationController(rootViewController: homeModule))
        }
    }
}
