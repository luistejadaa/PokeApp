//
//  CreateGroupView.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class CreateGroupView: BaseViewController {

    // MARK: Properties
    let pokemonsTableView: UITableView = {
        return CommonControls.generateTableView(style: .plain, cellClass: UITableViewCell.self, identifier: "pokemonCell")
    }()
    var presenter: CreateGroupPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        navigationItem.title = "Create group"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pushDoneButton))
        view.addSubview(pokemonsTableView)
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
        setupConstraints()
        
        super.viewDidLoad()
        presenter?.viewDidLoad()
        startActivity()
    }
    
    @objc func pushDoneButton() {
        
        if let presenter = presenter, !presenter.isEditMode() {
            let alert = UIAlertController(title: "Group", message: "Type a name for the group", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Group name"
            }
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
                if let name = alert.textFields?.first?.text, !name.isEmpty {
                    self.presenter?.saveGroup(name: name)
                } else {
                    self.presentAlert(with: nil, message: "Please fill the group name", actions: [UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        self.present(alert, animated: true, completion: nil)
                    })], completion: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.presenter?.updateGroup()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CreateGroupView: CreateGroupViewProtocol {
    
    func groupCreated(message: String) {
        presentAlert(with: nil, message: message, actions: [UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        })], completion: nil)
    }
    
    func reloadCell(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.pokemonsTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func displayError(_ error: Error) {
        presentAlert(with: "Error", message: error.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: nil)
    }
    
    func reloadData() {
        pokemonsTableView.reloadData()
        stopActivity()
    }
}

extension CreateGroupView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter?.movePokemon(from: sourceIndexPath, to: destinationIndexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getPokedexCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getPokemonCount(forPokedex: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        if let presenter = presenter {
            cell.accessoryType = presenter.checkIfPokemonIsAdded(at: indexPath) ? .checkmark : .none
            if let pokemon = presenter.getPokemonSpecies(at: indexPath) {
                cell.textLabel?.text = pokemon.species.name
                cell.imageView?.image = #imageLiteral(resourceName: "pokeballImage")
                if let image = pokemon.image {
                    cell.imageView?.image = image
                } else {
                    DispatchQueue.global(qos: .background).async {
                        presenter.getPokemonThumbnail(for: indexPath)
                    }
                }
            }
        }
        return cell
    }
}

extension CreateGroupView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let presenter = self.presenter else {return []}
        var action: UITableViewRowAction!
        if !presenter.checkIfPokemonIsAdded(at: indexPath) {
            action = UITableViewRowAction(style: .normal, title: "Add") { (_, indexPath) in
                presenter.addPokemon(at: indexPath)
            }
            action.backgroundColor = .systemGreen
        } else {
            action = UITableViewRowAction(style: .normal, title: "Remove") { (_, indexPath) in
                presenter.removePokemon(at: indexPath)
            }
            action.backgroundColor = .systemRed
        }
        return [action]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pushPokemon(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
