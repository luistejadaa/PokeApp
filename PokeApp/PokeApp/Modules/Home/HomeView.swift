//
//  HomeView.swift
//  PokeApp
//
//  Created by Intellisys on 24/2/21.
//  
//

import Foundation
import UIKit

class HomeView: BaseViewController {

    // MARK: Properties
    let regionTableView: UITableView = {
        return CommonControls.generateTableView(style: .plain, cellClass: UITableViewCell.self, identifier: "regionCell")
    }()
    var presenter: HomePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "signOutIcon"), style: .done, target: self, action: #selector(pushSignOutButton))
        regionTableView.dataSource = self
        regionTableView.delegate = self
        regionTableView.refreshControl = CommonControls.generateRefreshControl(target: self, action: #selector(refreshData), for: .valueChanged)
        navigationItem.title = "Areas"
        view.addSubview(regionTableView)
        setupConstraints()
        
        super.viewDidLoad()
        presenter?.viewDidLoad()
        startActivity()
    }
    
    @objc func pushSignOutButton() {
        presenter?.pushSignOut()
    }
    
    @objc func refreshData() {
        presenter?.viewDidLoad()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            regionTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            regionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            regionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            regionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeView: HomeViewProtocol {
    
    func displayError(_ error: Error) {
        presentAlert(with: "Error", message: error.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: nil)
    }
    
    func reloadData() {
        stopActivity()
        regionTableView.refreshControl?.endRefreshing()
        regionTableView.reloadData()
    }
}

extension HomeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  presenter!.getRegionCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell", for: indexPath)
        cell.textLabel?.text = presenter?.getRegion(at: indexPath.row)?.name.capitalized
        cell.textLabel?.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
        cell.textLabel?.textColor = .mainYellow
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRegion(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
