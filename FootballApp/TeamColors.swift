//
//  TeamColors.swift
//  FootballApp
//
//  Created by yujaehong on 10/16/24.
//

import UIKit

struct TeamColors {
    static let colors: [String: UIColor] = [
        "Liverpool": UIColor(red: 200/255.0, green: 16/255.0, blue: 46/255.0, alpha: 1.0), // Liverpool Red
        "Manchester City": UIColor(red: 108/255.0, green: 171/255.0, blue: 221/255.0, alpha: 1.0), // Manchester City Sky Blue
        "Arsenal": UIColor(red: 239/255.0, green: 1/255.0, blue: 7/255.0, alpha: 1.0), // Arsenal Red
        "Chelsea": UIColor(red: 3/255.0, green: 70/255.0, blue: 148/255.0, alpha: 1.0), // Chelsea Blue
        "Aston Villa": UIColor(red: 0.6, green: 0.0, blue: 0.2, alpha: 1.0), // Claret
        "Brighton": UIColor(red: 0.0, green: 0.392, blue: 0.694, alpha: 1.0), // Brighton Blue
        "Newcastle": UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), // Black
        "Fulham": UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), // Black
        "Tottenham": UIColor(red: 19/255.0, green: 34/255.0, blue: 87/255.0, alpha: 1.0), // Tottenham Navy
        "Nottingham Forest": UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0), // Forest Red
        "Brentford": UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0), // Brentford Red
        "West Ham": UIColor(red: 0.6, green: 0.0, blue: 0.2, alpha: 1.0), // Claret
        "Bournemouth": UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), // Black
        "Manchester United": UIColor(red: 218/255.0, green: 41/255.0, blue: 28/255.0, alpha: 1.0), // Manchester United Red
        "Leicester": UIColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1.0), // Leicester Blue
        "Everton": UIColor(red: 0.0, green: 0.0, blue: 0.6, alpha: 1.0), // Everton Blue
        "Ipswich": UIColor(red: 0.0, green: 0.0, blue: 0.6, alpha: 1.0), // Ipswich Blue
        "Crystal Palace": UIColor(red: 0.0, green: 0.2, blue: 0.5, alpha: 1.0), // Palace Blue
        "Southampton": UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0), // Southampton Red
        "Wolves": UIColor(red: 0.894, green: 0.4, blue: 0.0, alpha: 1.0), // Wolves Gold
    ]
    
    static func color(for team: String) -> UIColor {
        return colors[team] ?? UIColor.gray
    }
}
