//
//  Type.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation

struct Type: Codable {
    let slot: Int
    let type: RawType
}

struct RawType: Codable {
    let name: String
    let url: String
}
