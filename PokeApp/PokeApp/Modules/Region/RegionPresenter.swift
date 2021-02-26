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
    var groups: [Group]!
    
    init(with region: Region, view: RegionViewProtocol?, interactor: RegionInteractorInputProtocol, wireFrame: RegionWireFrameProtocol) {
        self.region = region
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
        groups = [Group]()
    }
    
}

extension RegionPresenter: RegionPresenterProtocol {
    func pushGroup(at index: Int) {
        wireFrame?.navigateToGroupDetail(from: view!, region: region!, group: groups[index])
    }

    func getGroupsCount() -> Int {
        return groups.count
    }
    
    func getGroupName(at index: Int) -> String {
        return groups[index].name.capitalized
    }
    
    func pushCreateGroup() {
        if let view = view, let region = region {
            wireFrame?.navigateToCreateGroup(from: view, for: region)
        }
    }
    
    func viewDidLoad() {
        if let region = region {
            view?.updateTitle(regionName: region.name)
            interactor?.requestGroups(forRegionId: region.regionId!)
        }
    }
}

extension RegionPresenter: RegionInteractorOutputProtocol {
    func didLoad(error: Error) {
        view?.displayError(error: error)
    }
    func didLoad(groups: [Group]) {
        self.groups = groups
        view?.reloadData()
    }
}
