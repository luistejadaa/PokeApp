//
//  HomePresenter.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation

class HomePresenter {
    
    // MARK: Properties
    var regions: [Region]!
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
    init(view: HomeViewProtocol?, interactor: HomeInteractorInputProtocol, wireFrame: HomeWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func pushSignOut() {
        interactor?.requestSignOut()
    }
    
    func getRegionCount() -> Int {
        regions?.count ?? 0
    }
    
    func getRegion(at index: Int) -> Region? {
        regions?[index]
    }
    
    func viewDidLoad() {
        interactor?.requestRegions()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func didLoad(regions: [Region]) {
        self.regions = regions
        view?.reloadData()
    }
    func didLoad(error: Error) {
        view?.displayError(error)
    }
    func didSignOut() {
        wireFrame?.navigateToLogin()
    }
}
