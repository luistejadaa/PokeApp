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
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
