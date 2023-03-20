//
//  UIImageView+extension.swift
//  Pokemon
//
//  Created by Aliaksandr Miatnikau on 20.03.23.
//

import UIKit
extension UIImageView {
    
    func getImage(url: URL) {
        
        tag = +1
        let currentTag = tag
        
        let cacheId = url.absoluteString as NSString
        
        if let imageData = imageCache.object(forKey:cacheId) {
            self.image = UIImage(data:imageData as Data)
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            if error == nil, let data = data {
                
                DispatchQueue.main.async {
                    imageCache.setObject(data as NSData, forKey: cacheId)
                    if (currentTag == self?.tag) {
                        self?.image = UIImage(data: data)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
