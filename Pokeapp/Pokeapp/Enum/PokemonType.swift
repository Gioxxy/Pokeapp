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
            return #colorLiteral(red: 0.8470588235, green: 0.262745098, blue: 0.08235294118, alpha: 1)
        case .flying:
            return #colorLiteral(red: 0.3607843137, green: 0.4196078431, blue: 0.7529411765, alpha: 1)
        case .poison:
            return #colorLiteral(red: 0.5333333333, green: 0.3803921569, blue: 1, alpha: 1)
        case .ground:
            return #colorLiteral(red: 0.7882352941, green: 0.6509803922, blue: 0.4980392157, alpha: 1)
        case .rock:
            return #colorLiteral(red: 0.5529411765, green: 0.431372549, blue: 0.3882352941, alpha: 1)
        case .bug:
            return #colorLiteral(red: 0.4745098039, green: 0.8509803922, blue: 0.2196078431, alpha: 1)
        case .ghost:
            return #colorLiteral(red: 0.4784313725, green: 0.2666666667, blue: 0.537254902, alpha: 1)
        case .steel:
            return #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case .fire:
            return #colorLiteral(red: 1, green: 0.3725490196, blue: 0.3960784314, alpha: 1)
        case .water:
            return #colorLiteral(red: 0.3764705882, green: 0.7411764706, blue: 1, alpha: 1)
        case .grass:
            return #colorLiteral(red: 0, green: 0.831372549, blue: 0.6823529412, alpha: 1)
        case .electric:
            return #colorLiteral(red: 1, green: 0.7921568627, blue: 0.1568627451, alpha: 1)
        case .psychic:
            return #colorLiteral(red: 0.6705882353, green: 0.2784313725, blue: 0.737254902, alpha: 1)
        case .ice:
            return #colorLiteral(red: 0, green: 0.8823529412, blue: 0.9843137255, alpha: 1)
        case .dragon:
            return #colorLiteral(red: 0.3960784314, green: 0.1215686275, blue: 1, alpha: 1)
        case .dark:
            return #colorLiteral(red: 0.1607843137, green: 0.1607843137, blue: 0.1607843137, alpha: 1)
        case .fairy:
            return #colorLiteral(red: 1, green: 0.5882352941, blue: 0.6862745098, alpha: 1)
        case .unknown:
            return #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
        case .shadow:
            return #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        }
    }
}
