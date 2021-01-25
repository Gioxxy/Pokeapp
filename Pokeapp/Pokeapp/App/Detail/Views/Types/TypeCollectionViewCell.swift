//
//  TypeTableViewCell.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import UIKit

final class TypeCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "TypeTableViewCell"
    
    private let title: UILabel = {
        let title = UILabel()
        title.text = "GRASS"
        title.textColor = UIColor.white
        title.font = UIFont(name: "AvenirNext-Bold", size: 18)
        title.textAlignment = .center
        return title
    }()
    
    func config(type: PokemonType) {
        title.text = type.rawValue.uppercased()
        contentView.backgroundColor = type.color()
        
        setupView()
        addViews()
    }
    
    private func setupView(){
        contentView.layer.cornerRadius = 35/2
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    private func addViews(){
        // Add title
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
