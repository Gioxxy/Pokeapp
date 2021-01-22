//
//  ImageViewerCoordinator.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 22/01/21.
//

import UIKit

final class ImageViewerCoordinator {
    private let navigationController: SwipeBackNavigationController
    private let viewModel: ImageViewerViewModel
    
    init(navigationController: SwipeBackNavigationController, pokemonModel: PokemonModel){
        self.navigationController = navigationController
        viewModel = ImageViewerViewModel(pokemonModel: pokemonModel)
    }
    
    func start(){
        viewModel.coordinator = self
        let vc = ImageViewerViewController()
        vc.config(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onBackDidTap() {
        navigationController.popViewController(animated: true)
    }
}
