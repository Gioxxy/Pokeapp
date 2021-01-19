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
    
    var delegate: DetailViewControllerDelegate?
    
    
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
        title.textAlignment = .center
        view.addSubview(title)
        title.sizeToFit()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: arrowBack.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
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
        view.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            container.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
        
        // Add stats
        let statsTableView = UITableView()
        statsTableView.delegate = self
        statsTableView.dataSource = self
        statsTableView.register(StatTableViewCell.self, forCellReuseIdentifier: StatTableViewCell.cellId)
        statsTableView.showsVerticalScrollIndicator = false
        statsTableView.showsHorizontalScrollIndicator = false
        statsTableView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        statsTableView.separatorStyle = .none
        statsTableView.allowsSelection = false
        statsTableView.rowHeight = 35
        
        container.addSubview(statsTableView)
        statsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statsTableView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            statsTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            statsTableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            statsTableView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        
    }
    
    @objc private func onBackTap(sender: UIButton!){
        delegate?.onBackDidTap()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.cellId, for: indexPath) as! StatTableViewCell
        return cell
    }
    
}
