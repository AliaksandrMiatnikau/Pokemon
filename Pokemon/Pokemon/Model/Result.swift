//
//  Result.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation

struct Result: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
