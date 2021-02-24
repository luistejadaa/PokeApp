//
//  LoginInteractor.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//  
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
}

extension LoginInteractor: UserAppDelegate {
    func userDidSigIn(error: Error?) {
        if let error = error {
            presenter?.didLoad(error: error)
        } else {
            presenter?.didSigIn()
        }
    }
}
