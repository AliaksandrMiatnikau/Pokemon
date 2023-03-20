//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon?.name?.capitalized
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func identifier(section: Int) -> String {
        return section == 0 ? "DetailImageTableViewCell" : "DetailPropertiesTableViewCell"
    }
    
    func height(section: Int) -> CGFloat {
        let screen = UIScreen.main.bounds
        let imageHeight =  UIDevice.current.orientation.isLandscape ? screen.height : screen.width
        return section == 0 ? imageHeight : 214
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.height(section: indexPath.section)
    }
}
