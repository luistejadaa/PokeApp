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
}

protocol LoginWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
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
}

protocol LoginInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
}

protocol LoginDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}
