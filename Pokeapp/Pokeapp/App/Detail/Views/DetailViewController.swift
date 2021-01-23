//
//  DetailViewController.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var detailViewModel: DetailViewModel?
    
    private let statsTableView = StatsTableView()
    private let typesCollectionView = TypeCollectionView()
    
    private let backButtoon: UIButton = {
        let arrowBack = UIButton(type: .custom)
        arrowBack.setImage(UIImage(named: "arrowBack"), for: .normal)
        arrowBack.addTarget(self, action: #selector(onBackTap), for: .touchUpInside)
        return arrowBack
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 40)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.white
        idLabel.font = UIFont(name: "AvenirNext-Bold", size: 20)
        idLabel.textAlignment = .left
        return idLabel
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        container.layer.shadowRadius = 3
        container.layer.shadowOpacity = 0.2
        container.layer.masksToBounds = false
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds, cornerRadius: container.layer.cornerRadius).cgPath
        return container
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        imageView.layer.shadowRadius = 3
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.masksToBounds = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func config(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        view.backgroundColor = detailViewModel.type.color()
        titleLabel.text = detailViewModel.name
        idLabel.text = detailViewModel.namedId
        imageView.imageFromNetwork(url: detailViewModel.imageURL)
        typesCollectionView.config(types: detailViewModel.types)
        statsTableView.config(stats: detailViewModel.stats)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImageTap(tapGestureRecognizer:))))
        
        addViews()
    }

    private func addViews() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Add pokeball
        let pokeball = UIImageView(image: UIImage(named: "pokeball"))
        view.addSubview(pokeball)
        pokeball.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokeball.topAnchor.constraint(equalTo: view.topAnchor),
            pokeball.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            pokeball.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            pokeball.centerXAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(UIScreen.main.bounds.width/7))
        ])
        
        // Add back button
        view.addSubview(backButtoon)
        backButtoon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButtoon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            backButtoon.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 18)
        ])
        
        // Add title
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButtoon.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 18)
        ])
        
        // Add id
        view.addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Add container
        view.addSubview(containerView)
        let bottomInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0 ? 0 : -18
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: bottomInset),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Add image
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 80),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -80),
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 400)
        ])
        
        // Add types
        containerView.addSubview(typesCollectionView.collectionView)
        typesCollectionView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typesCollectionView.collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            typesCollectionView.collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            typesCollectionView.collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            typesCollectionView.collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add stats
        containerView.addSubview(statsTableView.tableView)
        statsTableView.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsTableView.tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            statsTableView.tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            statsTableView.tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            statsTableView.tableView.bottomAnchor.constraint(equalTo: typesCollectionView.collectionView.topAnchor)
        ])
    }
    
    @objc private func onBackTap(sender: UIButton!){
        detailViewModel?.onBackDidTap()
    }
    
    @objc private func onImageTap(tapGestureRecognizer: UITapGestureRecognizer!){
        detailViewModel?.onImageDidTap()
    }
}
