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
    
    init(mainModel: MainModel, pokemons: [PokemonModel]) {
        self.mainModel = mainModel
        self.pokemonModels = pokemons
        
        self.nextPageURL = URL(string: mainModel.next ?? "")
        if let urlComponents = URLComponents(string: mainModel.next ?? "") {
            let queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
            self.nextOffset = Int(queryItems.first(where: { $0.name == "offset" })?.value ?? "")
        }else{
            self.nextOffset = nil
        }
        
        self.pokemons = pokemons.map({ return PokemonViewModel(pokemon: $0) })
    }
    
    init() {}
    
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
                
                self.pokemons.append(contentsOf: pokemons.map({ return PokemonViewModel(pokemon: $0) }))
                onSuccess?()
            },
            onError: {
                onError?()
            }
        )
    }
    
}

class PokemonViewModel {
    let id: Int
    let name: String
    let type: PokemonType
    let imageURL: URL?
    
    init(pokemon: PokemonModel) {
        id = pokemon.id
        name = pokemon.name.capitalized.replacingOccurrences(of: "-", with: " - ")
        imageURL = URL(string: (pokemon.sprites?.other?.officialArtwork?.frontDefault ?? pokemon.sprites?.frontDefault) ?? "")
        type = PokemonType(rawValue: pokemon.types?.first?.type.name ?? "unknown") ?? PokemonType.unknown
    }
}
