//
//  RegionPresenter.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

class RegionPresenter {
    
    // MARK: Properties
    weak var view: RegionViewProtocol?
    var interactor: RegionInteractorInputProtocol?
    var wireFrame: RegionWireFrameProtocol?
    var region: Region?
    
    init(with region: Region, view: RegionViewProtocol?, interactor: RegionInteractorInputProtocol, wireFrame: RegionWireFrameProtocol) {
        self.region = region
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
}

extension RegionPresenter: RegionPresenterProtocol {
    func viewDidLoad() {
        
        if let region = region {
            view?.updateTitle(regionName: region.name)
        }
    }
}

extension RegionPresenter: RegionInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
