//
//  MainManager.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

class MainManager {
    func getPokemons(offset: Int = 0, onSuccess: ((_ mainViewModel: MainViewModel)->Void)? = nil, onError: (()->Void)? = nil){
        PokeAPI.get(
            route: "/pokemon",
            params: ["offset": String(offset)],
            onSuccess: { data in
                do {
                    let decoder = JSONDecoder.init()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let mainModel = try decoder.decode(MainModel.self, from: data)
                    var pokemons: [PokemonModel] = []
                    
                    let group = DispatchGroup()
                    mainModel.results?.forEach { pokemon in
                        if let url = pokemon.url?.replacingOccurrences(of: PokeAPI.server, with: ""){
                            group.enter()
                            PokeAPI.get(route: url) { data in
                                do {
                                    pokemons.append(try decoder.decode(PokemonModel.self, from: data))
                                } catch {
                                    print("error \(pokemon.name ?? ""): \(error)")
                                }
                                group.leave()
                            } onError: {
                                print("error \(pokemon.name ?? "")")
                                group.leave()
                            }
                        }
                    }
                    group.notify(queue: .main) {
                        pokemons.sort(by: { $0.id < $1.id })
                        onSuccess?(MainViewModel(mainModel: mainModel, pokemons: pokemons))
                    }
                } catch {}
            }
        )
    }
}
