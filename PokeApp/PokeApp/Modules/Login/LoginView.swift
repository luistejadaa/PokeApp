//
//  LoginView.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//  
//

import UIKit
import GoogleSignIn

class LoginView: BaseViewController {

    let titleLabel: UILabel = {
        return LabelBuilder(frame: .zero)
            .text("POKEAPP")
            .textColor(.white)
            .font(.boldSystemFont(ofSize: 48))
            .build()
    }()
    
    let sigInButton: GIDSignInButton = {
        let button = GIDSignInButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: Properties
    var presenter: LoginPresenterProtocol?

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainYellow
        GIDSignIn.sharedInstance()?.presentingViewController = self
        view.addSubview(titleLabel)
        view.addSubview(sigInButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            sigInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sigInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            sigInButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.1)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension LoginView: LoginViewProtocol {
    func displayError(_ error: Error) {
        presentAlert(with: "Error", message: error.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: nil)
    }
}
