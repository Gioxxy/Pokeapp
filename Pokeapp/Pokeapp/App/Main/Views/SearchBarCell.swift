//
//  SearchBarCell.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 24/01/21.
//

import UIKit

class SearchBarCell: UICollectionReusableView, UISearchBarDelegate {
    static let cellId = "SearchBarCell"
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.tintColor = .black
//        searchBar.backgroundColor = #colorLiteral(red: 0.9175556302, green: 0.9110012054, blue: 0.9225750566, alpha: 1)
        searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return searchBar
    }()
    
    var timer: Timer?
    
    var onSearch: ((String)->Void)?
    var onEndSearch: (()->Void)?
        
    func config(onSearch: ((String)->Void)? = nil, onEndSearch: (()->Void)? = nil){
        searchBar.delegate = self
        self.onSearch = onSearch
        self.onEndSearch = onEndSearch
        
        self.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
        
        setupShadow()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let inset = UIScreen.main.bounds.width.truncatingRemainder(dividingBy: 173) / 2
        
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: inset),
            searchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -inset),
            searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 112),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupShadow(){
        searchBar.layer.cornerRadius = 10
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        searchBar.layer.shadowRadius = 3
        searchBar.layer.shadowOpacity = 0.2
        searchBar.layer.masksToBounds = false
        searchBar.layer.shadowPath = UIBezierPath(roundedRect: searchBar.bounds, cornerRadius: searchBar.layer.cornerRadius).cgPath
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            if searchText == "" {
                self.timer?.invalidate()
                self.timer = nil
                self.onEndSearch?()
            } else {
                self.onSearch?(searchText)
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        onSearch?(searchBar.text ?? "")
    }
    
}
