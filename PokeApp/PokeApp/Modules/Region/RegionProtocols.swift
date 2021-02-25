//
//  RegionProtocols.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

protocol RegionViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: RegionPresenterProtocol? { get set }
    func updateTitle(regionName: String)
}

protocol RegionWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule(with: Region) -> UIViewController
}

protocol RegionPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: RegionViewProtocol? { get set }
    var interactor: RegionInteractorInputProtocol? { get set }
    var wireFrame: RegionWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol RegionInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol RegionInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: RegionInteractorOutputProtocol? { get set }
    var remoteDatamanager: RegionRemoteDataManagerInputProtocol? { get set }
}

protocol RegionDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol RegionRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: RegionRemoteDataManagerOutputProtocol? { get set }
}

protocol RegionRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol GroupServiceProtocol: class {
    associatedtype GroupType
    func getGroups(completion: @escaping (Result<[GroupType], Error>) -> Void)
}
