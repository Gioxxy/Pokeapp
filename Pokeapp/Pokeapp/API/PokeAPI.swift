//
//  Request.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

class PokeAPI {
    
    static let server = "https://pokeapi.co/api/v2"
    static let cache = URLCache(
        memoryCapacity: 0,
        diskCapacity: 100*1024*1024,
        diskPath: "PokeAPICache"
    )
    
    private static func createAndRetrieveURLSession() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        return URLSession(configuration: sessionConfiguration)
    }
    
    static func get(route: String, params: Dictionary<String, String>? = nil, onSuccess: ((_ data: Data)->Void)? = nil, onError: (()->Void)? = nil){
        
        guard route.count > 0 else { onError?(); return }
        
        var url = URL(string: server + route)!
        if let params = params {
            url.appendQueryParams(params)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.cachePolicy = .useProtocolCachePolicy
        
        if let data = cache.cachedResponse(for: request)?.data {
            onSuccess?(data)
        } else {
            createAndRetrieveURLSession().dataTask(with: request, completionHandler: { data, response, error -> Void in
    //            print("RES " + url.absoluteString)
                if let error = error {
                    print("Network error: " + error.localizedDescription)
                    onError?()
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    print("Not a HTTP response")
                    onError?()
                    return
                }
                guard response.statusCode == 200 else {
                    print("Invalid HTTP status code \(response.statusCode)")
                    onError?()
                    return
                }
                guard let data = data else {
                    print("No HTTP data")
                    onError?()
                    return
                }
                
                cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
                onSuccess?(data)
            }).resume()
        }

       
    }
}
