//
//  RegionView.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class RegionView: BaseViewController {

    // MARK: Properties
    let groupTableView: UITableView =  {
        return CommonControls.generateTableView(style: .plain, cellClass: UITableViewCell.self, identifier: "groupCell")
    }()
    var presenter: RegionPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushCreateGroupButton))
        
        view.addSubview(groupTableView)
        groupTableView.delegate = self
        groupTableView.dataSource = self
        let refreshControl = CommonControls.generateRefreshControl(target: self, action: #selector(refreshData), for: .valueChanged)
        groupTableView.refreshControl = refreshControl
        setupConstraints()
        super.viewDidLoad()
    }
    
    @objc func refreshData() {
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
        startActivity()
    }
    
    @objc func pushCreateGroupButton() {
        presenter?.pushCreateGroup()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            groupTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            groupTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            groupTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            groupTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension RegionView: RegionViewProtocol {
    func displayError(error: Error) {
        presentAlert(with: "Error", message: error.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: nil)
    }
    func reloadData() {
        groupTableView.reloadData()
        stopActivity()
        groupTableView.refreshControl?.endRefreshing()
    }
    func updateTitle(regionName: String) {
        navigationItem.title = regionName.capitalized
    }
}

extension RegionView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getGroupsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        cell.textLabel?.text = presenter?.getGroupName(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Groups created in this area"
    }
}

extension RegionView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pushGroup(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let presenter = self.presenter else {return []}
        let action = UITableViewRowAction(style: .normal, title: "Remove") { (_, indexPath) in
            presenter.removeGroup(at: indexPath.row)
        }
        action.backgroundColor = .systemRed
        return [action]
    }
}
