//
//  PokemonTypes.swift
//  Pokeapp
//
//  Created by Gionatan Cernusco on 21/01/21.
//

import UIKit

enum PokemonType: String {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
    
    func color() -> UIColor {
        switch self {
        case .normal:
            return #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
        case .fighting:
            return UIColor.accent
        case .flying:
            return UIColor.accent
        case .poison:
            return #colorLiteral(red: 0.5333333333, green: 0.3803921569, blue: 1, alpha: 1)
        case .ground:
            return UIColor.accent
        case .rock:
            return #colorLiteral(red: 0.7882352941, green: 0.6509803922, blue: 0.4980392157, alpha: 1)
        case .bug:
            return #colorLiteral(red: 0.4745098039, green: 0.8509803922, blue: 0.2196078431, alpha: 1)
        case .ghost:
            return #colorLiteral(red: 0.4784313725, green: 0.2666666667, blue: 0.537254902, alpha: 1)
        case .steel:
            return UIColor.accent
        case .fire:
            return #colorLiteral(red: 1, green: 0.3725490196, blue: 0.3960784314, alpha: 1)
        case .water:
            return #colorLiteral(red: 0.3764705882, green: 0.7411764706, blue: 1, alpha: 1)
        case .grass:
            return #colorLiteral(red: 0, green: 0.831372549, blue: 0.6823529412, alpha: 1)
        case .electric:
            return #colorLiteral(red: 1, green: 0.8470588235, blue: 0.3490196078, alpha: 1)
        case .psychic:
            return UIColor.accent
        case .ice:
            return #colorLiteral(red: 0.3803921569, green: 1, blue: 1, alpha: 1)
        case .dragon:
            return UIColor.accent
        case .dark:
            return #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
        case .fairy:
            return #colorLiteral(red: 1, green: 0.5882352941, blue: 0.6862745098, alpha: 1)
        case .unknown:
            return UIColor.accent
        case .shadow:
            return UIColor.accent
        }
    }
}
