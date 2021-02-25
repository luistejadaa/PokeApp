//
//  GroupDetailWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

class GroupDetailWireFrame: GroupDetailWireFrameProtocol {

    class func createModule(groupName: String, species: [PokemonSpecies]) -> UIViewController {
        let view = GroupDetailView()
        let interactor = GroupDetailInteractor(remoteDatamanager: GroupDetailRemoteDataManager())
        let wireFrame = GroupDetailWireFrame()
        let presenter = GroupDetailPresenter(species: species, view: view, interactor: interactor, wireFrame: wireFrame, groupName: groupName)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.remoteDatamanager?.remoteRequestHandler = interactor
        return view
    }
    
}
