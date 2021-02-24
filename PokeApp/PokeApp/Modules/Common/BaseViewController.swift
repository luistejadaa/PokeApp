//
//  BaseViewController.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func presentAlert(with title: String?, message: String?, actions: [UIAlertAction], completion: (() -> Void )?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addActions(actions)
        present(alert, animated: true, completion: completion)
    }
}
