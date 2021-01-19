//
//  MainCollectionView.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "MainCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = UIColor.accent
        contentView.layer.cornerRadius = 10
        
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        
        // Add container
        let view = UIView()
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        //Add image
        let image = UIImageView(image: UIImage(named: "bulbasaur"))
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        image.layer.shadowRadius = 3
        image.layer.shadowOpacity = 0.2
        image.layer.masksToBounds = false
        view.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        // Add title
        let title = UILabel()
        title.text = "Bulbasaur"
        title.textColor = UIColor.white
        title.font = UIFont(name: "AvenirNext-Bold", size: 20)
        title.textAlignment = .center
        view.addSubview(title)
        title.sizeToFit()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
