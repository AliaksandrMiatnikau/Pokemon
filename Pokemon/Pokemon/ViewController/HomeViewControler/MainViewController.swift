//
//  MainViewController.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

final class MainViewController: UIViewController {
    var reachability: ReachabilityProtocol?
    var VM: MainViewModelProtocol?
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinnerView: UIView!
    
    private let cardWidth: CGFloat = 95
    private let minSpace: CGFloat = 20
    private let alertTitle = "Error"
    private let alertMessage = "No internet connection"
    private let alertAnswer = "OK"
    
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        VM = MainViewModel()
        reachability = Reachability()
        
        self.spinnerView.isHidden = false
        if reachability?.isOK() == true {
            VM?.loadMainData{ [weak self] pokemos in
                DispatchQueue.main.async {
                    self?.spinnerView.isHidden = true
                    self?.collectionView.reloadData()
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
    
    
    private func showAlert() {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertAnswer, style: .default, handler: nil)
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
        return VM?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        guard let poke = VM?.resultData()?[indexPath.row] else { return cell }
        cell.pokeName.text = poke.name.capitalized
        if let url = poke.mainImage {
            cell.pokeImageView.getImage(url: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if VM?.shouldLoadMoreResults(indexPath, numberOfCells: VM?.numberOfCellsToDownload() ?? 3) == true {
            
            if reachability?.isOK() == true   {
                VM?.loadNextResult()
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
            } else {
                showAlert()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailViewController")
        if let vc = viewController as? DetailViewController
            {
            vc.VM = VM?.viewModelForSelectedRow(for: indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cardWidth = cardWidth
        let minSpace = minSpace
        let howManyCards = floor(screenWidth / (cardWidth + minSpace))
        let spaces = howManyCards + 1
        let margin = (screenWidth - (cardWidth * howManyCards)) / spaces
        return UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
    }
}
