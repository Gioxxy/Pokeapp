//
//  ImageViewerViewController.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 22/01/21.
//

import UIKit

final class ImageViewerViewController: UIViewController, UIScrollViewDelegate {
    private var viewModel: ImageViewerViewModel?

    private let pageView: PageViewCollectionView = PageViewCollectionView()
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private let backButtoon: UIButton = {
        let backButtoon = UIButton(type: .custom)
        backButtoon.setImage(UIImage(named: "arrowBack"), for: .normal)
        backButtoon.addTarget(self, action: #selector(onButtonTap(sender:)), for: .touchUpInside)
        return backButtoon
    }()
    
    func config(viewModel: ImageViewerViewModel){
        self.viewModel = viewModel
        pageControl.numberOfPages = viewModel.imageURLs.count
        pageView.config(
            imageURLs: viewModel.imageURLs,
            onPageDidChange: { currentPage in
                self.pageControl.currentPage = currentPage
            }
        )
        
        setupView()
        addViews()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.black
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func addViews() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Add Page Control
        view.addSubview(self.pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add CollectionView as PageView
        view.addSubview(self.pageView.collectionView)
        pageView.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageView.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            pageView.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            pageView.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            pageView.collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // Add back button
        view.addSubview(backButtoon)
        backButtoon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButtoon.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            backButtoon.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 18)
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @objc private func onButtonTap(sender: UIButton!){
        viewModel?.onBackDidTap()
    }
}
