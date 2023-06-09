//
//  MainViewController.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

protocol MainViewModelProtocol {
    func resultData() -> [ResultViewModel]?
    func numberOfCellsToDownload() -> Int
    func numberOfRows() -> Int
    func loadMainData(completion: @escaping ([ResultViewModel]?) -> ())
    func shouldLoadMoreResults(_ indexPath:IndexPath, numberOfCells: Int ) -> Bool
    func loadNextResult(completion: @escaping ([ResultViewModel]?) -> ())
    func viewModelForSelectedRow(for indexPath: IndexPath) -> DetailViewModelProtocol?
}


final class MainViewModel: MainViewModelProtocol {
    
    let services: ServicesProtocol? = Services()
    private let numberOfCellsToDownloadNew = 3
    var results: [ResultViewModel]?
    
    func resultData() -> [ResultViewModel]? {
        return results
    }
    
    func numberOfCellsToDownload() -> Int {
        return numberOfCellsToDownloadNew
    }
    
    func loadMainData(completion: @escaping ([ResultViewModel]?) -> ())  {
        services?.getPokemons { [weak self] pokemos, hasError in
            if !hasError {
                self?.results = pokemos
                completion(pokemos)
            }
        }
    }
    
    
    internal func shouldLoadMoreResults(_ indexPath:IndexPath, numberOfCells: Int ) -> Bool {
        
        guard let quantity = results?.count else { return false }
        if quantity == 0 { return false }
        if indexPath.row == (quantity -  numberOfCells) {
            return true
        } else {
            return false
        }
    }
    
    internal func loadNextResult(completion: @escaping ([ResultViewModel]?) -> ())  {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [weak self] in
            self?.services?.getMorePokemons { [weak self] pokemos, hasError in
                if !hasError {
                    pokemos?.forEach({ self?.results?.append($0) })
                    DispatchQueue.main.async {
                        completion(self?.results)
                    }
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        return results?.count ?? 0
    }
    func viewModelForSelectedRow(for indexPath: IndexPath) -> DetailViewModelProtocol? {
        let pokemon = results?[indexPath.row]
        return DetailViewModel(pokemon: pokemon?.pokemon)
    }
}

