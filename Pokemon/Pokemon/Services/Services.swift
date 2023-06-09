//
//  Services.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import Foundation
import UIKit

protocol ServicesProtocol {
    func getPokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())? )
    func getMorePokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())?)
    func getPokemon(url: String,  completion: ((Pokemon?, _ hasError: Bool) -> ())?)
    func downloadImage(url: URL, completion:@escaping (UIImage?, Data?) -> ())
}

final class Services: ServicesProtocol {
    
    let request: RequestProtocol? = Request()
    let router: MyRouterProtocol? = NetworkRouter()
    var lastResult: Api?
    
    func getPokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())? = nil) {
        let url = router?.getURL() ?? ""
        request?.send(url: url) { (data) in
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            let decoder = JSONDecoder()
            do {
                let api = try decoder.decode(Api.self, from: jsonData)
                self.lastResult = api
                let group = DispatchGroup()
                var results = [ResultViewModel]()
                api.results.forEach { result in
                    group.enter()
                    let resultViewModel = ResultViewModel(result: result)
                    resultViewModel.onDetailLoad = {
                        results.append(resultViewModel)
                        group.leave()
                    }
                }
                group.notify(queue: DispatchQueue.global()) {
                    completion?(results, false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getMorePokemons(completion: (([ResultViewModel]?, _ hasError: Bool) -> ())? = nil) {
        
        guard let url = lastResult?.next else {
            completion?(nil, true)
            return
        }
        request?.send(url: url) { (data) in
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            let decoder = JSONDecoder()
            do {
                let api = try decoder.decode(Api.self, from: jsonData)
                self.lastResult = api
                let group = DispatchGroup()
                var results = [ResultViewModel]()
                api.results.forEach { result in
                    group.enter()
                    let resultViewModel = ResultViewModel(result: result)
                    resultViewModel.onDetailLoad = {
                        results.append(resultViewModel)
                        group.leave()
                    }
                }
                group.notify(queue: DispatchQueue.global()) {
                    completion?(results, false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemon(url: String,  completion: ((Pokemon?, _ hasError: Bool) -> ())? = nil) {
        request?.send(url: url) { (data) in
            guard let jsonData = data else{
                completion?(nil, true)
                return
            }
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: jsonData)
                completion?(pokemon, false)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadImage(url: URL, completion:@escaping (UIImage?, Data?) -> ()) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if error == nil, let data = data {
                completion(UIImage(data: data), data)
            } else {
                completion(nil, nil)
                print("Unable to download image")
            }
        }
        dataTask.resume()
    }
}
