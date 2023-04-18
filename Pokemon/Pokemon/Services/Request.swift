//
//  Request.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit

let imageCache = NSCache<NSString, NSData>()

protocol RequestProtocol {
    func send(url: String, completion:@escaping (Data?) -> ())
   static func downloadImage(url: String, completion:@escaping (UIImage?) -> ())
}

final class Request: RequestProtocol{
   
    var currentUrl: String?
    
    func send(url: String, completion:@escaping (Data?) -> ()) {
        self.currentUrl = url
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if (error == nil && data != nil) {
                completion(data)
            } else {
                completion(nil);
            }
        }
        dataTask.resume()
    }
    
    // downloading from cache
    static func downloadImage(url: String, completion:@escaping (UIImage?) -> ()) {
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let cacheId = url.absoluteString as NSString
        if let imageData = imageCache.object(forKey:cacheId) {
            completion(UIImage(data: imageData as Data))
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil, let data = data {
                imageCache.setObject(data as NSData, forKey: cacheId)
                completion(UIImage(data: data))
            } else {
                completion(nil);
            }
        }
        dataTask.resume()
    }
}
