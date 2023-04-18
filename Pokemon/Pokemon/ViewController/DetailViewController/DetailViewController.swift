//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var VM: DetailViewModelProtocol?
    let imageHeightConstant: CGFloat = 214
    let nilNumber = 0
    let heightMeasure = "cm"
    let weigthMeasure = "kg"
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = VM?.pokemonName.capitalized
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func identifier(section: Int) -> String {
        return section == 0 ? "DetailImageTableViewCell" : "DetailPropertiesTableViewCell"
    }
    
    private func height(section: Int) -> CGFloat {
        let screen = UIScreen.main.bounds
        let imageHeight =  UIDevice.current.orientation.isLandscape ? screen.height : screen.width
        return section == 0 ? imageHeight : imageHeightConstant
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: UITableView configuration
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier(section: indexPath.section))
        if indexPath.section == 0 {
            guard let cell = cell as? DetailImageTableViewCell else { return cell ?? UITableViewCell() }
            if let imageUrl = VM?.pokemonImageURL,
               let url = URL(string: imageUrl) {
                Services.shared.downloadImage(url: url) { image, data in
                    DispatchQueue.main.async {
                        cell.pokeImageView.image = image
                    }
                }
            }
            return cell
            
        } else {
            guard let cell = cell as? DetailPropertiesTableViewCell else { return cell ?? UITableViewCell() }
            
            cell.labelHeight.text  = "\(VM?.pokemonHeight ?? nilNumber) \(heightMeasure)"
            cell.labelWeight.text  = "\(VM?.pokemonWeight ?? nilNumber) \(weigthMeasure)"
            cell.labelSpecies.text = VM?.pokemonSpecies
            cell.labelType.text    = VM?.pokemonType
            cell.labelAbility.text = VM?.pokemoneAbilities
            cell.labelNumber.text  = "\(VM?.pokemonNumber ?? nilNumber)"
            
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.height(section: indexPath.section)
    }
}
