//
//  PokemonView.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

class PokemonView: UIViewController {

    // MARK: Properties
   
    var presenter: PokemonPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PokemonView: PokemonViewProtocol {
    // TODO: implement view output methods
}
