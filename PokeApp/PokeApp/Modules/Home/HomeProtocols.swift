//
//  HomeProtocols.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: HomePresenterProtocol? { get set }
    func displayError(_ error: Error)
    func reloadData()
}

protocol HomeWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    func navigateToLogin()
    func navigateToRegion(from: HomeViewProtocol?, with region: Region)
}

protocol HomePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getRegionCount() -> Int
    func getRegion(at index: Int) -> Region?
    func pushSignOut()
    func didSelectRegion(at index: Int)
}

protocol HomeInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    
    func didLoad(regions: [Region])
    func didLoad(error: Error)
    func didSignOut()
}

protocol HomeInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    func requestRegions()
    func requestSignOut()
}

protocol HomeDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func getRegions()
}

protocol HomeRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func didReceived(_ result: Result<[Region], Error>)
}

protocol RegionServiceProtocol: class {
    associatedtype RegionType
    func getRegions(completion: @escaping (Result<[RegionType], Error>) -> Void)
}
