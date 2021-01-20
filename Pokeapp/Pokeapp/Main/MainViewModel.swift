//
//  MainViewModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import UIKit

class MainViewModel{
    
    var nextPageURL: URL?
    var nextOffset: Int?
    var pokemons: [PokemonViewModel]
    
    init(mainModel: MainModel, pokemons: [PokemonModel]) {
        self.nextPageURL = URL(string: mainModel.next ?? "")
        if let urlComponents = URLComponents(string: mainModel.next ?? "") {
            let queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
            self.nextOffset = Int(queryItems.first(where: { $0.name == "offset" })?.value ?? "")
        }else{
            self.nextOffset = nil
        }
        
        self.pokemons = pokemons.map({ return PokemonViewModel(pokemon: $0) })
    }
    
}

class PokemonViewModel {
    
    let id: Int
    let name: String
    let color: UIColor
    let imageURL: URL?
    
    init(pokemon: PokemonModel) {
        id = pokemon.id
        name = pokemon.name.capitalized
        imageURL = URL(string: (pokemon.sprites?.other?.officialArtwork?.frontDefault ?? pokemon.sprites?.frontDefault) ?? "")
        
        switch pokemon.types?.first?.type.name {
        case "normal":
            color = UIColor.PokemonType.normal
        case "fighting":
            color = UIColor.accent
        case "flying":
            color = UIColor.accent
        case "poison":
            color = UIColor.PokemonType.poison
        case "ground":
            color = UIColor.accent
        case "rock":
            color = UIColor.PokemonType.rock
        case "bug":
            color = UIColor.PokemonType.bug
        case "ghost":
            color = UIColor.PokemonType.gosth
        case "steel":
            color = UIColor.accent
        case "fire":
            color = UIColor.PokemonType.fire
        case "water":
            color = UIColor.PokemonType.water
        case "grass":
            color = UIColor.PokemonType.grass
        case "electric":
            color = UIColor.PokemonType.electric
        case "psychic":
            color = UIColor.accent
        case "ice":
            color = UIColor.PokemonType.ice
        case "dragon":
            color = UIColor.accent
        case "dark":
            color = UIColor.PokemonType.dark
        case "fairy":
            color = UIColor.PokemonType.fary
        case "unknown":
            color = UIColor.accent
        case "shadow":
            color = UIColor.accent
        default:
            color = UIColor.accent
        }
    }
}
