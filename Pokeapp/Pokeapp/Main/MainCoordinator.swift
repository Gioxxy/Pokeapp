//
//  MainCoordinator.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import Foundation
import UIKit

class MainCoordinator {
    
    var navigationController: UINavigationController
    let manager = MainManager()
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        let vc = MainViewController()
        vc.delegate = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    func fetchData(offset: Int, onSuccess: ((MainViewModel) -> Void)?, onError: (() -> Void)?) {
        manager.getPokemons(
            offset: offset,
            onSuccess: { mainViewModel in
                onSuccess?(mainViewModel)
            },
            onError: {
                onError?()
            }
        )
    }
    
    func onPokemonDidTap(){
        DetailCoordinator(navigationController: navigationController).start()
    }
}
