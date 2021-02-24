//
//  UIAlertController+Extension.swift
//  PokeApp
//
//  Created by Intellisys on 23/2/21.
//

import UIKit.UIAlertController

extension UIAlertController {
    func addActions( _ actions: [UIAlertAction]) {
        for action in actions {
            addAction(action)
        }
    }
}
