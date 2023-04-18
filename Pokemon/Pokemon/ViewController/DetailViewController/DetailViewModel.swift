//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

protocol DetailViewModelProtocol {
    
    var pokemonName:       String { get }
    var pokemonHeight:        Int { get }
    var pokemonWeight:        Int { get }
    var pokemonSpecies:    String { get }
    var pokemonType:       String { get }
    var pokemoneAbilities: String { get }
    var pokemonNumber:        Int { get }
    var pokemonImageURL:   String { get }
}

final class DetailViewModel: DetailViewModelProtocol {
    
    
    
    var pokemon: Pokemon?
    
    var pokemonName: String {
        guard let name = pokemon?.name else { return "" }
        return name
    }
    
    var pokemonHeight: Int {
        guard let height = pokemon?.height else { return 0 }
        return height
    }
    
    var pokemonWeight: Int {
        guard let weight = pokemon?.weight else { return 0 }
        return weight
    }
    
    var pokemonSpecies: String {
        guard let specie = pokemon?.species?.name else { return "" }
        return specie
    }
    
    var pokemonType: String {
        guard let type = pokemon?.types?.first?.type.name else { return "" }
        return type
    }
    
    var pokemoneAbilities: String {
        guard let ability = pokemon?.abilities?.first?.ability.name else { return "" }
        return ability
    }
    
    var pokemonNumber: Int {
        guard let number = pokemon?.id else { return 0 }
        return number
    }
    
    var pokemonImageURL: String {
        guard let url = pokemon?.sprites?.other?.official_artwork?.front_default else { return "" }
        return url
    }
    
    init(pokemon: Pokemon?) {
        self.pokemon = pokemon
    }
}

