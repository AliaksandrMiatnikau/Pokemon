//
//  Ability.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation

struct Ability: Codable {
    let ability: RawAbility
    let is_hidden: Bool
    let slot: Int
}

struct RawAbility: Codable {
    let name: String
    let url: String
}
