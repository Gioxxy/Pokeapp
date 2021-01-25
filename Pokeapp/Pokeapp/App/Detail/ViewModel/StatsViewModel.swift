//
//  StatViewModel.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 23/01/21.
//

import Foundation

final class StatsViewModel: Equatable {
    let name: String
    let value: Int
    let progressValue: Float
    
    init(stats: Stats){
        value = stats.baseStat
        // Stats max values are based on https://www.serebii.net/pokedex-swsh/stat/hp.shtml
        switch stats.stat.name {
        case "hp":
            name = "HP"
            progressValue = (Float(value))/255 // Gen VIII Dex max HP = 255
        case "attack":
            name = "Attack"
            progressValue = Float(value)/181 // Gen VIII Dex max ATK = 181
        case "defense":
            name = "Defense"
            progressValue = Float(value)/230 // Gen VIII Dex max DEF = 230
        case "special-attack":
            name = "Sp. ATK"
            progressValue = Float(value)/173 // Gen VIII Dex max SP.ATK = 173
        case "special-defense":
            name = "Sp. DEF"
            progressValue = Float(value)/230 // Gen VIII Dex max SP.DEF = 230
        case "speed":
            name = "Speed"
            progressValue = Float(value)/200 // Gen VIII Dex max SPD = 200
        default:
            name = ""
            progressValue = 0
        }
    }
    
    static func == (lhs: StatsViewModel, rhs: StatsViewModel) -> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value && lhs.progressValue == rhs.progressValue
    }
}
