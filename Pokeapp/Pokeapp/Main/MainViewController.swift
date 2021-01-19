//
//  ViewController.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func onPokemonDidTap()
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.primary
        
        // Add SafeArea
        let safeArea = UIView()
        view.addSubview(safeArea)
        safeArea.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            safeArea.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            safeArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        // Add logo
        let logo = UIImageView(image: UIImage(named: "pokeLogo"))
        safeArea.addSubview(logo)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalToConstant: 92),
            logo.widthAnchor.constraint(equalToConstant: 249),
            logo.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        
    }

}

