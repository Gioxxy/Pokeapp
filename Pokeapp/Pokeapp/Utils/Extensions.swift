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
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
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
