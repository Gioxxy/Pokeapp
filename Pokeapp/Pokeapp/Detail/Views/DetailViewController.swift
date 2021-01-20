//
//  DetailViewController.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func onBackDidTap()
}

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var delegate: DetailViewControllerDelegate? // TODO Sould be weak
    let statsTableView = StatsTableView()
    let typesCollectionView = TypeCollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeBack()
        setupView()
    }
    
    func enableSwipeBack(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setupView() {
        view.backgroundColor = UIColor.accent
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
        let arrowBack  = UIButton(type: .custom)
        arrowBack.setImage(UIImage(named: "arrowBack"), for: .normal)
        arrowBack.addTarget(self, action: #selector(onBackTap), for: .touchUpInside)
        view.addSubview(arrowBack)
        
        arrowBack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowBack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            arrowBack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 18)
        ])
        
        // Add title
        let title = UILabel()
        title.text = "Bulbasaur"
        title.textColor = UIColor.white
        title.font = UIFont(name: "AvenirNext-Bold", size: 40)
        title.textAlignment = .left
        view.addSubview(title)
        title.sizeToFit()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: arrowBack.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 18)
        ])
        
        // Add id
        let id = UILabel()
        id.text = "#001"
        id.textColor = UIColor.white
        id.font = UIFont(name: "AvenirNext-Bold", size: 20)
        id.textAlignment = .left
        view.addSubview(id)
        id.sizeToFit()
        
        id.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            id.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            id.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Add container
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        container.layer.shadowRadius = 3
        container.layer.shadowOpacity = 0.2
        container.layer.masksToBounds = false
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds, cornerRadius: container.layer.cornerRadius).cgPath
        view.addSubview(container)
        
        let bottomInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0 ? 0 : -18
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            container.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: bottomInset),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
        ])
        
        // Add image
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
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        // Add types
        container.addSubview(typesCollectionView.collectionView)
        typesCollectionView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typesCollectionView.collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            typesCollectionView.collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            typesCollectionView.collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            typesCollectionView.collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Add stats
        container.addSubview(statsTableView.tableView)
        statsTableView.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsTableView.tableView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            statsTableView.tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            statsTableView.tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            statsTableView.tableView.bottomAnchor.constraint(equalTo: typesCollectionView.collectionView.topAnchor)
        ])
        
        
    }
    
    @objc private func onBackTap(sender: UIButton!){
        delegate?.onBackDidTap()
    }
}
