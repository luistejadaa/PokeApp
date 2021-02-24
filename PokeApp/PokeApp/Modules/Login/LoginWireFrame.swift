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
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
