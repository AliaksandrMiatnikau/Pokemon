//
//  Api.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation

struct Api: Codable {
    let count: Int
    let next: String
    let results: [Result]
    
    init(count: Int, next: String, results: [Result]) {
        self.count = count
        self.next = next
        self.results = results
    }
    
}
