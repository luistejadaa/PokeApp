//
//  CreateGroupProtocols.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import UIKit

protocol CreateGroupViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: CreateGroupPresenterProtocol? { get set }
    func displayError(_ error: Error)
    func reloadData()
    func reloadCell(at indexPath: IndexPath)
    func groupCreated(message: String)
}

protocol CreateGroupWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule(group: Group?, with region: Region, delegate: CreateGroupDelegate?) -> UIViewController
    func navigateToPokemonDetail(from: CreateGroupViewProtocol, pokemonId: Int)
}

protocol CreateGroupPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: CreateGroupViewProtocol? { get set }
    var interactor: CreateGroupInteractorInputProtocol? { get set }
    var wireFrame: CreateGroupWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getPokedexCount() -> Int
    func getPokemonCount(forPokedex: Int) -> Int
    func getPokemonName(at index: Int, forPokedex: Int) -> String?
    func getPokedexName(at index: Int) -> String?
    func getPokemonThumbnail(for indexPath: IndexPath)
    func checkIfPokemonIsAdded(at indexPath: IndexPath) -> Bool
    func addPokemon(at indexPath: IndexPath)
    func removePokemon(at indexPath: IndexPath)
    func getPokemonSpecies(at indexPath: IndexPath) -> PokemonSpecies?
    func saveGroup(name: String)
    func pushPokemon(at indexPath: IndexPath)
    func movePokemon(from: IndexPath, to: IndexPath)
    func isEditMode() -> Bool
    func updateGroup()
}

protocol CreateGroupInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func didLoad(pokedexes: [Pokedex])
    func didLoad(error: Error)
    func didLoad(image: UIImage, pokemonId: Int)
    func didGroupCreated(error: Error?)
}

protocol CreateGroupInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: CreateGroupInteractorOutputProtocol? { get set }
    var remoteDatamanager: CreateGroupRemoteDataManagerInputProtocol? { get set }
    func requestPokedexes(regionName: String)
    func requestThumbnail(pokemonId: Int)
    func requestNewGroup(group: inout Group)
    
}

protocol CreateGroupDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol CreateGroupRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CreateGroupRemoteDataManagerOutputProtocol? { get set }
    func getPokemons(for regionName: String)
    func getThumbnail(pokemonId: Int)
    func createGroup(group: Group)
}

protocol CreateGroupRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func didReceived(_ result: Result<[Pokedex], Error>)
    func didReceived(_ image: UIImage, pokemonId: Int)
    func createGroupHandler(error: Error?)
}
