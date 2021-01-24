//
//  MainViewModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

class MainViewModel{
    
    var coordinator: MainCoordinator?
    
    private var mainModel: MainModel?
    private var pokemonModels: [PokemonModel]? = []
    
    var nextPageURL: URL?
    var nextOffset: Int?
    var pokemons: [PokemonViewModel] = []
    var isSearching: Bool = false
    
    func onPokemonDidTap(pokemonViewModel: PokemonViewModel){
        if let pokemonModel = pokemonModels?.first(where: { pokemonViewModel.id == $0.id }) {
            coordinator?.onPokemonDidTap(pokemonModel: pokemonModel)
        }
    }
    
    func getPokemons(offset: Int, onSuccess: (()->Void)?, onError: (()->Void)?){
        coordinator?.getPokemons(
            offset: offset,
            onSuccess: { mainModel, pokemons in
                
                self.mainModel = mainModel
                self.pokemonModels?.append(contentsOf: pokemons)
                
                self.nextPageURL = URL(string: mainModel.next ?? "")
                if let urlComponents = URLComponents(string: mainModel.next ?? "") {
                    let queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
                    self.nextOffset = Int(queryItems.first(where: { $0.name == "offset" })?.value ?? "")
                }else{
                    self.nextOffset = nil
                }
                
                self.pokemons.append(contentsOf: pokemons.map({ return PokemonViewModel(pokemonModel: $0) }))
                onSuccess?()
            },
            onError: {
                onError?()
            }
        )
    }
    
    func searchPokemon(name: String, onSuccess: (()->Void)?, onError: (()->Void)?){
        coordinator?.searchPokemon(
            name: name.lowercased(),
            onSuccess: { pokemon in
                self.isSearching = true
                self.mainModel = nil
                self.pokemonModels = [pokemon]
                self.nextPageURL = nil
                self.nextOffset = nil
                self.pokemons = [PokemonViewModel(pokemonModel: pokemon)]
                onSuccess?()
            },
            onError: {
                onError?()
            }
        )
    }
    
    func endSearch(offset: Int, onSuccess: (()->Void)?, onError: (()->Void)?){
        isSearching = false
        pokemonModels = []
        pokemons = []
        getPokemons(offset: offset, onSuccess: onSuccess, onError: onError)
    }
    
}
