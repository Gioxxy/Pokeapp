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
    
    let collectionView: UICollectionView = {
        let inset = UIScreen.main.bounds.width.truncatingRemainder(dividingBy: 173) / 2
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 20
        flow.minimumLineSpacing = 20
        flow.itemSize = CGSize(width: 163, height: 163)
        flow.sectionInset = UIEdgeInsets(top: 112, left: inset, bottom: 30, right: inset)
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
    }()
    
    var logo: UIImageView?
    
    let data = ["1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.background
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
        
        // Add logo
        logo = UIImageView(image: UIImage(named: "pokeLogo"))
        if let logo = logo {
            view.addSubview(logo)
            logo.contentMode = .scaleAspectFit
            
            logo.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                logo.topAnchor.constraint(equalTo: safeArea.topAnchor),
                logo.heightAnchor.constraint(equalToConstant: 92),
                logo.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
            ])
        }
        
        // Add CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.contentLayoutGuide.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
        ])
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as! MainCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onPokemonDidTap()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 5 {
            UIView.animate(withDuration: 0.5) {
                self.logo?.alpha = 1
            }
        } else if self.logo?.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                self.logo?.alpha = 0
            }
        }
    }
}

