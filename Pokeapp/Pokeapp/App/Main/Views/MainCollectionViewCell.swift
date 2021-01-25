//
//  MainCollectionView.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "MainCollectionViewCell"
    
    private let view: UIView = {
        let view = UIView()
        return view
    }()
    
    private let image: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        image.layer.shadowRadius = 3
        image.layer.shadowOpacity = 0.2
        image.layer.masksToBounds = false
        image.layer.shouldRasterize = true
        image.layer.rasterizationScale = UIScreen.main.scale
        return image
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white
        title.font = UIFont(name: "AvenirNext-Bold", size: 20)
        title.textAlignment = .center
        return title
    }()
    
    func config(pokemon: PokemonViewModel) {
        contentView.backgroundColor = pokemon.type.color()
        image.imageFromNetwork(url: pokemon.imageURL)
        title.text = pokemon.name
        
        setupView()
        addViews()
    }
    
    private func setupView(){
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    private func addViews(){
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
