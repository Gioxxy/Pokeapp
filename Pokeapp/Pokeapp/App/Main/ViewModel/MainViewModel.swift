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
    
}
