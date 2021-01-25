//
//  DetailViewModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 21/01/21.
//

import Foundation

protocol DetailViewModelDelegate: class {
    func onBackDidTap()
}

final class DetailViewModel {
    
    var coordinator: DetailCoordinator?
    private var pokemonModel: PokemonModel
    
    let id: Int
    let name: String
    let namedId: String
    let type: PokemonType
    let imageURL: URL?
    let weight: String
    let height: String
    let stats: [StatsViewModel]
    let types: [PokemonType]
    
    init(pokemonModel: PokemonModel) {
        self.pokemonModel = pokemonModel
        id = pokemonModel.id
        name = pokemonModel.name.capitalized.replacingOccurrences(of: "-", with: " - ")
        namedId = String(format: "#%03d", pokemonModel.id)
        type = PokemonType(rawValue: pokemonModel.types?.first?.type.name ?? "unknown") ?? PokemonType.unknown
        imageURL = URL(string: (pokemonModel.sprites?.other?.officialArtwork?.frontDefault ?? pokemonModel.sprites?.frontDefault) ?? "")
        weight = String(Float(pokemonModel.weight ?? 0) / 10) + " Kg"
        height = String(Float(pokemonModel.height ?? 0) / 10) + " m"
        stats = pokemonModel.stats?.map({ StatsViewModel(stats: $0) }) ?? []
        types = pokemonModel.types?.map({ PokemonType(rawValue: $0.type.name) ?? PokemonType.unknown }) ?? []
        
    }
    
    func onBackDidTap(){
        coordinator?.onBackDidTap()
    }
    
    func onImageDidTap(){
        coordinator?.onImageDidTap(pokemonModel: pokemonModel)
    }
}
