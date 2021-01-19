//
//  DetailCoordinator.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import Foundation
import UIKit

class DetailCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        let vc = DetailViewController()
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func onBackDidTap() {
        navigationController.popViewController(animated: true)
    }
}
