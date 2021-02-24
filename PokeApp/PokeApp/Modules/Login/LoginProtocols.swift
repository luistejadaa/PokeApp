//
//  LoginProtocols.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//  
//

import Foundation
import UIKit

protocol LoginViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    func displayError(_ error: Error)
}

protocol LoginWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    func navigateToHome()
}

protocol LoginPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol LoginInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func didSigIn()
    func didLoad(error: Error)
}

protocol LoginInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
}

protocol LoginDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}
