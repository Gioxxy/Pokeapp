//
//  StatCell.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 19/01/21.
//

import UIKit

final class StatTableViewCell: UITableViewCell {
    
    static let cellId = "StatTableViewCell"
    
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.gray
        title.font = UIFont(name: "AvenirNext-Bold", size: 15)
        title.textAlignment = .left
        return title
    }()
    
    private let value: UILabel = {
        let value = UILabel()
        value.textColor = UIColor.black
        value.font = UIFont(name: "AvenirNext-Bold", size: 18)
        value.textAlignment = .right
        return value
    }()
    
    private let progress: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = UIColor.black
        progress.setProgress(0.45, animated: true)
        return progress
    }()
    
    func config(stat: StatsViewModel) {
        title.text = stat.name
        value.text = String(stat.value)
        progress.setProgress(stat.progressValue, animated: false)
        
        addViews()
    }
    
    private func addViews(){
        // Add title
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35)
        ])
        
        // Add value
        contentView.addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            value.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            value.trailingAnchor.constraint(equalTo: contentView.centerXAnchor) //, constant: -50)
        ])
        
        // Add progress
        contentView.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progress.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progress.leadingAnchor.constraint(equalTo: value.trailingAnchor, constant: 20),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            progress.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}
