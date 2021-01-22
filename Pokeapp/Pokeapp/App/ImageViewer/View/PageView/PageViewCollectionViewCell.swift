//
//  ImageViewerCollectionViewCell.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 22/01/21.
//

import UIKit

class PageViewCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "PageViewCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func config(imageURL: URL) {
        imageView.imageFromNetwork(url: imageURL)
        addViews()
    }
    
    private func addViews(){
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -30),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 400),
            imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
    }
}
