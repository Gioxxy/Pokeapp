//
//  TypeTableViewCell.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "TypeTableViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        
        contentView.backgroundColor = UIColor.accent
        contentView.layer.cornerRadius = 35/2
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        // Add title
        let title = UILabel()
        title.text = "GRASS"
        title.textColor = UIColor.white
        title.font = UIFont(name: "AvenirNext-Bold", size: 18)
        title.textAlignment = .center
        contentView.addSubview(title)
        title.sizeToFit()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        
    }
}
