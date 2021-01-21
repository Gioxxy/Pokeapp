//
//  ViewController.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func fetchData(offset: Int, onSuccess: ((_ mainViewModel: MainViewModel)->Void)?, onError: (()->Void)?)
    func onPokemonDidTap()
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    var mainViewModel: MainViewModel?
    private var currentOffset: Int = 0
    
    let collectionView: UICollectionView = {
        let inset = UIScreen.main.bounds.width.truncatingRemainder(dividingBy: 173) / 2
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 20
        flow.minimumLineSpacing = 20
        flow.itemSize = CGSize(width: 163, height: 163)
        flow.sectionInset = UIEdgeInsets(top: 112, left: inset, bottom: 30, right: inset)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        
        return collectionView
    }()
    
    let logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "pokeLogo"))
        logo.contentMode = .scaleAspectFit
        return logo
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        delegate?.fetchData(
            offset: currentOffset,
            onSuccess: { mainViewModel in
                self.mainViewModel = mainViewModel
                self.collectionView.reloadData()
            },
            onError: {}
        )
    }
    
    func setupView(){
        view.backgroundColor = UIColor.background
        let safeArea = view.safeAreaLayoutGuide
        
        // Pokeball
        let pokeball = UIImageView(image: UIImage(named: "pokeball"))
        view.addSubview(pokeball)
        pokeball.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokeball.topAnchor.constraint(equalTo: view.topAnchor),
            pokeball.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            pokeball.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            pokeball.centerXAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -(UIScreen.main.bounds.width/7))
        ])
        
        // Logo
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: safeArea.topAnchor),
            logo.heightAnchor.constraint(equalToConstant: 92),
            logo.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        // GridView
        collectionView.dataSource = self
        collectionView.delegate = self
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainViewModel?.pokemons.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.cellId, for: indexPath) as! MainCollectionViewCell
        if let pokemon = mainViewModel?.pokemons[indexPath.row] {
            cell.config(pokemon: pokemon)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onPokemonDidTap()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 163, height: 163)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let mainViewModel = mainViewModel, mainViewModel.pokemons.count > 0, indexPath.row == mainViewModel.pokemons.count - 1 {
            // TODO Request next data
            delegate?.fetchData(
                offset: mainViewModel.nextOffset ?? 0,
                onSuccess: { mainViewModel in
                    self.mainViewModel?.nextPageURL = mainViewModel.nextPageURL
                    self.mainViewModel?.nextOffset = mainViewModel.nextOffset
                    self.mainViewModel?.pokemons.append(contentsOf: mainViewModel.pokemons)
                    
                    var paths = [IndexPath]()
                    for i in 0..<mainViewModel.pokemons.count {
                        paths.append(IndexPath(row: (self.mainViewModel?.pokemons.count ?? 0) + i, section: 0))
                    }
                    self.collectionView.performBatchUpdates {
                        self.collectionView.insertItems(at: paths)
                    }
                },
                onError: {}
            )
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 5 {
            UIView.animate(withDuration: 0.5) {
                self.logo.alpha = 1
            }
        } else if self.logo.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                self.logo.alpha = 0
            }
        }
    }
}

