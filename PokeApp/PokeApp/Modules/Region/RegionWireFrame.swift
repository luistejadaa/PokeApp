//
//  RegionWireFrame.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class RegionWireFrame: RegionWireFrameProtocol {

    class func createModule(with region: Region) -> UIViewController {
        let view = RegionView()
        let interactor = RegionInteractor(remoteDatamanager: RegionRemoteDataManager())
        let wireFrame = RegionWireFrame()
        let presenter = RegionPresenter(with: region, view: view, interactor: interactor, wireFrame: wireFrame)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.remoteDatamanager?.remoteRequestHandler = interactor
        return view
    }
}
