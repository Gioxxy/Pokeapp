//
//  ImageViewerViewModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 22/01/21.
//

import Foundation

final class ImageViewerViewModel {
    var coordinator: ImageViewerCoordinator?
    
    var imageURLs: [URL] = []
    
    init(pokemonModel: PokemonModel) {
        let images = [
            pokemonModel.sprites?.other?.officialArtwork?.frontDefault,
//            pokemonModel.sprites?.other?.dreamWorld?.frontDefault, // SVGs not supported
//            pokemonModel.sprites?.other?.dreamWorld?.frontFemale, // SVGs not supported
            pokemonModel.sprites?.frontDefault,
            pokemonModel.sprites?.backDefault,
            pokemonModel.sprites?.frontShiny,
            pokemonModel.sprites?.backShiny,
            pokemonModel.sprites?.frontFemale,
            pokemonModel.sprites?.backFemale,
            pokemonModel.sprites?.frontShinyFemale,
            pokemonModel.sprites?.backShinyFemale,
        ]
        
        imageURLs.append(contentsOf: images.compactMap({ $0 }).compactMap({ URL(string: $0) }))
    }
    
    func onBackDidTap() {
        coordinator?.onBackDidTap()
    }
}
