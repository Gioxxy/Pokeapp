//
//  Extensions.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromNetwork(url: URL?) {
        guard let url = url else { return }
        let cache = URLCache(
            memoryCapacity: 0,
            diskCapacity: 100*1024*1024,
            diskPath: "PokeImageCache"
        )
        if let data = cache.cachedResponse(for: URLRequest(url: url))?.data {
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        } else {
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
            sessionConfiguration.urlCache = cache
            URLSession(configuration: sessionConfiguration).dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    cache.storeCachedResponse(CachedURLResponse(response: httpURLResponse, data: data), for: URLRequest(url: url))
                    self?.image = image
                }
            }.resume()
        }
    }
}

extension URL {

    mutating func appendQueryParam(key: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: key, value: value)
        
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        
        self = urlComponents.url!
    }
    
    mutating func appendQueryParams(_ params: Dictionary<String, String>) {
        params.forEach({ key, value in
            self.appendQueryParam(key: key, value: value)
        })
    }

}

extension UIViewController {
    func dismissKeyboardWhenViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
