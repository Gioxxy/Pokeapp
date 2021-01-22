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
    
    let id: Int
    let name: String
    let idString: String
    let type: PokemonType
    let imageURL: URL?
    let stats: [StatsViewModel]
    let types: [PokemonType]
    
    init(pokemonModel: PokemonModel) {
        id = pokemonModel.id
        name = pokemonModel.name.capitalized.replacingOccurrences(of: "-", with: " - ")
        idString = String(format: "#%03d", pokemonModel.id)
        type = PokemonType(rawValue: pokemonModel.types?.first?.type.name ?? "unknown") ?? PokemonType.unknown
        imageURL = URL(string: (pokemonModel.sprites?.other?.officialArtwork?.frontDefault ?? pokemonModel.sprites?.frontDefault) ?? "")
        stats = pokemonModel.stats?.map({ StatsViewModel(stats: $0) }) ?? []
        types = pokemonModel.types?.map({ PokemonType(rawValue: $0.type.name) ?? PokemonType.unknown }) ?? []
        
    }
    
    func onBackDidTap(){
        coordinator?.onBackDidTap()
    }
}

final class StatsViewModel {
    let name: String
    let value: Int
    let progressValue: Float
    
    init(stats: Stats){
        value = stats.baseStat
        // Stats max values are based on https://www.serebii.net/pokedex-swsh/stat/hp.shtml
        switch stats.stat.name {
        case "hp":
            name = "HP"
            progressValue = (Float(value))/255 // Gen VIII Dex max HP = 255
        case "attack":
            name = "Attack"
            progressValue = Float(value)/181 // Gen VIII Dex max ATK = 181
        case "defense":
            name = "Defense"
            progressValue = Float(value)/230 // Gen VIII Dex max DEF = 230
        case "special-attack":
            name = "Sp. ATK"
            progressValue = Float(value)/173 // Gen VIII Dex max SP.ATK = 173
        case "special-defense":
            name = "Sp. DEF"
            progressValue = Float(value)/230 // Gen VIII Dex max SP.DEF = 230
        case "speed":
            name = "Speed"
            progressValue = Float(value)/200 // Gen VIII Dex max SPD = 200
        default:
            name = ""
            progressValue = 0
        }
    }
}
