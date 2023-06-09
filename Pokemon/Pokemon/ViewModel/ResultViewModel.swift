//
//  ResultViewModel.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation

final class ResultViewModel {
    let result: Result
    let name: String
    var pokeId: String?
    var pokemon: Pokemon? {
        didSet {
            guard let urlString = self.pokemon?.sprites?.front_default else {
                return
            }
            self.mainImage = URL(string: urlString)
            self.pokeId = "\(pokemon?.id ?? 0)"
        }
    }
    var mainImage: URL?
    var onDetailLoad: (()->())?
    
    init(result: Result) {
        self.result = result
        self.name = result.name
        self.getPokemonDetail()
    }
    
    private func getPokemonDetail() {
        let service = Services()
        service.getPokemon(url: self.result.url) { [weak self] pokemon, hasError  in
            self?.pokemon = pokemon
            if let onDetailLoad = self?.onDetailLoad {
                onDetailLoad()
            }
        }
    }
}
