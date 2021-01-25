//
//  ViewController.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit


class MainViewController: UIViewController {
    
    private var mainViewModel: MainViewModel?
    private var initialOffset: Int = 0
    
    private let logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "pokeLogo"))
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private let collectionView: UICollectionView = {
        let inset = UIScreen.main.bounds.width.truncatingRemainder(dividingBy: 173) / 2
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 20
        flow.minimumLineSpacing = 20
        flow.itemSize = CGSize(width: 163, height: 163)
        flow.sectionInset = UIEdgeInsets(top: 20, left: inset, bottom: 30, right: inset)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.cellId)
        collectionView.register(SearchBarCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchBarCell.cellId)

        return collectionView
    }()
    
    func config(mainViewModel: MainViewModel){
        self.mainViewModel = mainViewModel
        dismissKeyboardWhenViewTapped()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = UIColor.background
        
        addViews()
        
        mainViewModel.getPokemons(
            offset: initialOffset,
            onSuccess: {
                self.collectionView.reloadData()
            },
            onError: {
                // TODO onError
            }
        )
    }
    
    private func addViews(){
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
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.contentLayoutGuide.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            collectionView.contentLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.contentLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.contentLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.contentLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
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
        if let pokemon = mainViewModel?.pokemons[indexPath.row] {
            mainViewModel?.onPokemonDidTap(pokemonViewModel: pokemon)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let mainViewModel = mainViewModel, !mainViewModel.isSearching, mainViewModel.pokemons.count > 0, indexPath.row == mainViewModel.pokemons.count - 1 {
            let pokemonCount = mainViewModel.pokemons.count
            mainViewModel.getPokemons(
                offset: mainViewModel.nextOffset ?? 0,
                onSuccess: {
                    var paths = [IndexPath]()
                    for i in 0..<(mainViewModel.pokemons.count - pokemonCount) {
                        paths.append(IndexPath(row: pokemonCount + i, section: 0))
                    }
                    self.collectionView.performBatchUpdates {
                        self.collectionView.insertItems(at: paths)
                    }
                },
                onError: {
                    // TODO onError
                }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 152)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchBarCell.cellId, for: indexPath) as! SearchBarCell
        header.config(
            onSearch: { text in
                print("Search " + text)
                self.mainViewModel?.searchPokemon(
                    name: text,
                    onSuccess: {
                        print("success")
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    },
                    onError: {
                        print("no pokemon named " + text)
                    }
                )
            },
            onEndSearch: {
                self.mainViewModel?.endSearch(
                    offset: self.initialOffset,
                    onSuccess: {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    },
                    onError: {
                        // TODO onError
                    }
                )
            }
        )
        return header
    }
}
