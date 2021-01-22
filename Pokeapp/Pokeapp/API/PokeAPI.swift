//
//  Request.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

class PokeAPI {
    
    static let server = "https://pokeapi.co/api/v2"
    
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

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
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
//            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
            onSuccess?(data)
        }).resume()
    }
}
