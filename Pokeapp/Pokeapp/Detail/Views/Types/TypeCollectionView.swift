//
//  TypeTableView.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import UIKit

class TypeCollectionView: UICollectionViewController {
    
    init (){
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 10
        flow.itemSize = CGSize(width: 120, height: 35)
        flow.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        super.init(collectionViewLayout: flow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        collectionView.register(TypeCollectionViewCell.self, forCellWithReuseIdentifier: TypeCollectionViewCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.allowsSelection = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCollectionViewCell.cellId, for: indexPath) as! TypeCollectionViewCell
        return cell
    }
}
