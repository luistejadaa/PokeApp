//
//  UserApp.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//

import Foundation
import Firebase
import GoogleSignIn

protocol UserAppDelegate: class {
    func userDidSigIn(error: Error?)
}

extension UserAppDelegate {
    func userDidSigIn(error: Error?) {
        //do something...
    }
}

final class UserApp: NSObject {

    static let shared: UserApp = {
        let instance = UserApp()
        return instance
    }()
    
    weak var delegate: UserAppDelegate?
    var firebaseUser: User? {
        return Auth.auth().currentUser
    }
    var userId: String? {
        firebaseUser?.uid
    }
    
    func signOut(completion: (Bool) -> Void) {
        if  firebaseUser != nil {
            do {
                try Auth.auth().signOut()
                completion(true)
            } catch {
                completion(false)
            }
        } else {
            completion(true)
        }
    }
}

extension UserApp: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        var displayError: Error?
        if error == nil {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                                accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (_, fAuthError) in
                if let fAuthError = fAuthError {
                    displayError = fAuthError
                } else {
                    self.delegate?.userDidSigIn(error: error)
                }
            }
        } else {
            displayError = error
        }
        if let displayError = displayError {
            self.delegate?.userDidSigIn(error: displayError)
        }
    }
}
