//
//  PokemonView.swift
//  PokeApp
//
//  Created by Intellisys on 25/2/21.
//  
//

import Foundation
import UIKit

class PokemonView: BaseViewController {

    // MARK: Properties
    let imageView: UIImageView = {
        return  CommonControls.generateImageView(with: #imageLiteral(resourceName: "pokeballImage"), contentMode: .scaleAspectFit)
    }()
    
    let detailTableView: UITableView = {
        return  CommonControls.generateTableView(style: .plain, cellClass: DetailTableViewCell.self, identifier: "detailCell")
    }()
    var presenter: PokemonPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(detailTableView)
        detailTableView.dataSource = self
        
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            detailTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PokemonView: PokemonViewProtocol {
    func reloadData() {
        detailTableView.reloadData()
        navigationItem.title = presenter?.getPokemonName()?.capitalized
    }
    
    func updateArt(image: UIImage) {
        imageView.image = image
    }
}

extension PokemonView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getDetailCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        let detail = presenter?.getDetail(at: indexPath.row)
        cell.textLabel?.text = detail?.title
        cell.detailTextLabel?.text = detail?.description
        return cell
    }
}
