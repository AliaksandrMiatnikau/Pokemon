//
//  NetworkRouter.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 25.04.23.
//

import Foundation
import UIKit


protocol MyRouterProtocol  {
    var basePath: String { get }
    var path: String { get }
    func getURL() -> String
}

final class NetworkRouter: MyRouterProtocol {
    private let router = PokemonsRouter.pokemons
    var basePath: String { return router.basePath }
    var path: String { return router.path }
    
   func getURL() -> String {
        return router.basePath + router.path
    }
}

public enum PokemonsRouter {
    case pokemons
    var basePath: String {
        return  "https://pokeapi.co"
    }
    var path: String {
        switch self {
        case .pokemons:
            return "/api/v2/pokemon"
        }
    }
}
