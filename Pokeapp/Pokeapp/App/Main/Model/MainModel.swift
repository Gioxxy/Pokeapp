//
//  MainModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 20/01/21.
//

import Foundation

// MARK: - MainModel
struct MainModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [ResultModel]?
}

// MARK: - Result
struct ResultModel: Codable {
    let name: String?
    let url: String?
}
