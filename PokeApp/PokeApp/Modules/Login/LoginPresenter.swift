//
//  LoginPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//  
//

import Foundation

class LoginPresenter {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
    init(view: LoginViewProtocol?, interactor: LoginInteractorInputProtocol, wireFrame: LoginWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
}

extension LoginPresenter: LoginPresenterProtocol {
    func viewDidLoad() {
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didSigIn() {
        wireFrame?.navigateToHome()
    }
    func didLoad(error: Error) {
        view?.displayError(error)
    }
}
