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
        setupConstraints()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
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
    func reloadData() {
        groupTableView.reloadData()
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
        return "Grupos"
    }
}

extension RegionView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pushGroup(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
