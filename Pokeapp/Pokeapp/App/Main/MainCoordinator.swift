//
//  MainCoordinator.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import Foundation
import UIKit

class MainCoordinator {
    private var navigationController: SwipeBackNavigationController
    private let manager = MainManager()
    private let mainViewModel: MainViewModel
    
    init(navigationController: SwipeBackNavigationController){
        self.navigationController = navigationController
        mainViewModel = MainViewModel()
    }
    
    func start(){
        mainViewModel.coordinator = self
        let vc = MainViewController()
        vc.config(mainViewModel: mainViewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func getPokemons(offset: Int, onSuccess: ((MainModel, [PokemonModel]) -> Void)?, onError: (() -> Void)?) {
        manager.getPokemons(
            offset: offset,
            onSuccess: { mainModel in
                var pokemons: [PokemonModel] = []
                let group = DispatchGroup()
                mainModel.results?.forEach { pokemon in
                    if let pokemonName = pokemon.name {
                        group.enter()
                        self.manager.getPokemon(name: pokemonName) { pokemonModel in
                            pokemons.append(pokemonModel)
                            group.leave()
                        } onError: {
                            group.leave()
                        }
                    }
                }
                group.notify(queue: .main) {
                    pokemons.sort(by: { $0.id < $1.id })
                    onSuccess?(mainModel, pokemons)
                }
            },
            onError: {
                
            }
        )
    }
    
    func onPokemonDidTap(pokemonModel: PokemonModel){
        DetailCoordinator(navigationController: navigationController, pokemonModel: pokemonModel).start()
    }
}
