//
//  PokemonModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

// MARK: - PokemonModel
struct PokemonModel: Codable {
    let id: Int
    let name: String
    let height: Int?
    let weight: Int?
    let sprites: Sprites?
    let stats: [Stats]?
    let types: [TypeElement]?
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: Other?
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String?
    let frontFemale: String?
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dreamWorld"
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?
}

// MARK: - Stats
struct Stats: Codable {
    let baseStat: Int
    let effort: Int
    let stat: Stat
}

// MARK: - Stat
struct Stat: Codable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Type
}

// MARK: - Type
struct Type: Codable {
    let name: String
    let url: String
}
