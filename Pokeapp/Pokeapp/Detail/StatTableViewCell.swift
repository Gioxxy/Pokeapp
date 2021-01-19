//
//  StatCell.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    
    static let cellId = "StatTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        //Add title
        let title = UILabel()
        title.text = "HP"
        title.textColor = UIColor.gray
        title.font = UIFont(name: "AvenirNext-Bold", size: 18)
        title.textAlignment = .left
        contentView.addSubview(title)
        title.sizeToFit()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25)
        ])
        
        // Add value
        let value = UILabel()
        value.text = "45"
        value.textColor = UIColor.black
        value.font = UIFont(name: "AvenirNext-Bold", size: 18)
        value.textAlignment = .right
        contentView.addSubview(value)
        value.sizeToFit()
        
        value.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            value.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            value.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -80)
        ])
        
        let progress = UIProgressView()
        progress.progressTintColor = UIColor.black
        progress.setProgress(0.45, animated: true)
        contentView.addSubview(progress)

        progress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progress.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progress.leadingAnchor.constraint(equalTo: value.trailingAnchor, constant: 20),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
        ])
    }
}
