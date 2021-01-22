//
//  MainManager.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

class MainManager {
    func getPokemons(offset: Int = 0, onSuccess: ((_ mainModel: MainModel)->Void)? = nil, onError: (()->Void)? = nil){
        PokeAPI.get(
            route: "/pokemon",
            params: ["offset": String(offset)],
            onSuccess: { data in
                do {
                    let decoder = JSONDecoder.init()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let mainModel = try decoder.decode(MainModel.self, from: data)
                    onSuccess?(mainModel)
                } catch {
                    print("error pokemons decode")
                    onError?()
                }
            }
        )
    }
    
    func getPokemon(name: String, onSuccess: ((_ pokemonModel: PokemonModel)->Void)? = nil, onError: (()->Void)? = nil){
        PokeAPI.get(route: "/pokemon/\(name)") { data in
            do {
                let decoder = JSONDecoder.init()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                onSuccess?(try decoder.decode(PokemonModel.self, from: data))
            } catch {
                print("error \(name): \(error)")
                onError?()
            }
        } onError: {
            print("error \(name)")
            onError?()
        }
    }
}
