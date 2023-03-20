//
//  Sprites.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation

struct Sprites: Codable {

    let front_default: String?
    let front_shiny: String?
    let other: Other?
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.front_default = try? values.decode(String.self, forKey: .front_default)
        self.front_shiny = try? values.decode(String.self, forKey: .front_shiny)
        self.other = try? values.decode(Other.self, forKey: .other)
    }
}

struct Other: Codable {
    let dream_world: DreamWord?
    let official_artwork: OfficialArtwork?
    private enum CodingKeys: String, CodingKey {
        case dream_world
        case official_artwork = "official-artwork"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.dream_world = try? values.decode(DreamWord.self, forKey: .dream_world)
        self.official_artwork = try? values.decode(OfficialArtwork.self, forKey: .official_artwork)
    }
}

struct DreamWord: Codable {
    let front_default: String
    let front_female: String
}

struct OfficialArtwork: Codable {
    let front_default: String
}
