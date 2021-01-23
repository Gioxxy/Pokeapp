//
//  PokemonViewModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 23/01/21.
//

import Foundation

class PokemonViewModel: Equatable {
    let id: Int
    let name: String
    let type: PokemonType
    let imageURL: URL?
    
    init(pokemonModel: PokemonModel) {
        id = pokemonModel.id
        name = pokemonModel.name.capitalized.replacingOccurrences(of: "-", with: " - ")
        imageURL = URL(string: (pokemonModel.sprites?.other?.officialArtwork?.frontDefault ?? pokemonModel.sprites?.frontDefault) ?? "")
        type = PokemonType(rawValue: pokemonModel.types?.first?.type.name ?? "unknown") ?? PokemonType.unknown
    }
    
    static func == (lhs: PokemonViewModel, rhs: PokemonViewModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.type == rhs.type && lhs.imageURL == rhs.imageURL
    }
}
