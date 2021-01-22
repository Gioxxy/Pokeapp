//
//  ImageViewerCollectionView.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 22/01/21.
//

import UIKit

final class PageViewCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var imageURLs: [URL]?
    private var onPageDidChange: ((Int)->Void)?
    
    init (){
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        super.init(collectionViewLayout: flow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView.register(PageViewCollectionViewCell.self, forCellWithReuseIdentifier: PageViewCollectionViewCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.allowsSelection = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
    }
    
    func config(imageURLs: [URL], onPageDidChange: ((Int)->Void)? = nil){
        self.imageURLs = imageURLs
        self.onPageDidChange = onPageDidChange
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let imageURL = imageURLs?[indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageViewCollectionViewCell.cellId, for: indexPath) as! PageViewCollectionViewCell
            cell.config(imageURL: imageURL)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(ceil(scrollView.contentOffset.x/scrollView.bounds.size.width))
        onPageDidChange?(currentPage)
    }
}
