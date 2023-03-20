//
//  MainViewController.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinnerView: UIView!
    
    let services = Services.shared
    let checkNetwork = Reachability.shared
    var results: [ResultViewModel]?
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinnerView.isHidden = false
        if checkNetwork.isOK() {
            services.getPokemons { [weak self] pokemos, hasError in
                if !hasError {
                    self?.results = pokemos
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                        self?.spinnerView.isHidden = true
                    }
                }
            }
        } else {
            showAlert()
            self.spinnerView.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    func shouldLoadMoreResults(_ indexPath:IndexPath ) -> Bool {
        
        guard let quantity = results?.count else { return false }
        if quantity == 0 { return false }
        if indexPath.row == (quantity - 3) {
            return true
        } else {
            return false
        }
    }
    
    func loadNextResult() {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
            self?.services.getMorePokemons { [weak self] pokemos, hasError in
                if !hasError {
                    pokemos?.forEach({ self?.results?.append($0) })
                    DispatchQueue.main.async { [weak self] in
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionView configuration
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        guard let poke = results?[indexPath.row] else { return cell }
        cell.pokeName.text = poke.name.capitalized
        if let url = poke.mainImage {
            cell.pokeImageView.getImage(url: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.shouldLoadMoreResults(indexPath) {
            if checkNetwork.isOK() {
                self.loadNextResult()
            } else {
                showAlert()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailViewController")
        if let vc = viewController as? DetailViewController {
            guard let poke = results?[indexPath.row] else { return }
            vc.pokemon = poke.pokemon
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cardWidth: CGFloat = 95
        let minSpace: CGFloat = 20
        let howManyCards = floor(screenWidth / (cardWidth + minSpace))
        let spaces = howManyCards + 1
        let margin = (screenWidth - (cardWidth * howManyCards)) / spaces
        return UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
    }
}
