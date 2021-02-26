//
//  GroupDetailView.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

class GroupDetailView: BaseViewController {

    // MARK: Properties
    let pokemonsTableView: UITableView =  {
        return CommonControls.generateTableView(style: .plain, cellClass: UITableViewCell.self, identifier: "pokemonCell")
    }()
    var presenter: GroupDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(pushEditButton))
        view.addSubview(pokemonsTableView)
        pokemonsTableView.dataSource = self
        pokemonsTableView.delegate = self
        setupConstraints()
        
        presenter?.viewDidLoad()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func pushEditButton() {
        presenter?.pushEditGroup()
    }
}

extension GroupDetailView: GroupDetailViewProtocol {
    func updateTitle(title: String) {
        navigationItem.title = title
    }
    
    func displayError(_ error: Error) {
        presentAlert(with: nil, message: error.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: nil)
    }
    
    func reloadData() {
        pokemonsTableView.reloadData()
    }
    
    func reloadCell(at index: Int) {
        pokemonsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

extension GroupDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getPokemonsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        if let pokemon = presenter?.getPokemon(at: indexPath.row) {
            cell.textLabel?.text = pokemon.species.name
            cell.imageView?.image = #imageLiteral(resourceName: "pokeballImage")
            if let image = pokemon.image {
                cell.imageView?.image = image
            } else {
                DispatchQueue.global(qos: .background).async {
                    if let pokemonId = pokemon.species.pokemonId {
                        self.presenter?.getPokemonThumbnail(pokemonId: pokemonId)
                    }
                }
            }
        }
        return cell
    }
}

extension GroupDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pushPokemon(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
