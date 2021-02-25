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
    func reloadData()
}

protocol RegionWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule(with: Region) -> UIViewController
    func navigateToCreateGroup(from: RegionViewProtocol, for: Region)
    func navigateToGroupDetail(from: RegionViewProtocol, _ species: [PokemonSpecies], groupName: String)
}

protocol RegionPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: RegionViewProtocol? { get set }
    var interactor: RegionInteractorInputProtocol? { get set }
    var wireFrame: RegionWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func pushCreateGroup()
    func getGroupsCount() -> Int
    func getGroupName(at index: Int) -> String
    func pushGroup(at index: Int)
}

protocol RegionInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func didLoad(groups: [Group])
}

protocol RegionInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: RegionInteractorOutputProtocol? { get set }
    var remoteDatamanager: RegionRemoteDataManagerInputProtocol? { get set }
    func requestGroups(forRegionId: Int)
}

protocol RegionDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol RegionRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: RegionRemoteDataManagerOutputProtocol? { get set }
    func getGroups(forRegionId: Int)
}

protocol RegionRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func didReceived(data: [[String: AnyObject]])
    func didReceived(error: Error)
}
