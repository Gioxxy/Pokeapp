//
//  DetailCoordinator.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import Foundation
import UIKit

final class DetailCoordinator {
    private let navigationController: SwipeBackNavigationController
    private let viewModel: DetailViewModel
    
    init(navigationController: SwipeBackNavigationController, pokemonModel: PokemonModel){
        self.navigationController = navigationController
        viewModel = DetailViewModel(pokemonModel: pokemonModel)
    }
    
    func start(){
        viewModel.coordinator = self
        let vc = DetailViewController()
        vc.config(detailViewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onBackDidTap() {
        navigationController.popViewController(animated: true)
    }
    
    func onImageDidTap(pokemonModel: PokemonModel){
        ImageViewerCoordinator(navigationController: navigationController, pokemonModel: pokemonModel).start()
    }
}
