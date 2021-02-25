//
//  RegionView.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class RegionView: BaseViewController {

    // MARK: Properties
    var presenter: RegionPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
}

extension RegionView: RegionViewProtocol {
    func updateTitle(regionName: String) {
        navigationItem.title = regionName.capitalized
    }
}
