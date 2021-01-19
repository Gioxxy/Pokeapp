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
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        let vc = MainViewController()
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    func onPokemonDidTap(){
        
    }
}
