//
//  Colorthemes.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/9/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UIKit

struct  ColorTheme {
    // Mark : -Instance vars
    static let light = ColorTheme(
                                  viewControllerBackgroundColor: .backgroundLight,
                                  primaryTextColor: .primaryTextWhite,
                                  secondaryTextColor: .secondaryTextWhite
                                 )
    
    static let dark = ColorTheme(
                                 viewControllerBackgroundColor: .backgroundDark,
                                 primaryTextColor: .primaryTextBlack,
                                 secondaryTextColor: .secondaryTextBlack
                                 )
    

    let viewControllerBackgroundColor: UIColor
    let primaryTextColor: UIColor
    
    let secondaryTextColor: UIColor
}

extension UIColor {

    static var materialLightGray = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0) // 424242

    static var primaryTextWhite = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    static var secondaryTextWhite = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.7)

    
    static var primaryTextBlack = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.87)
    
    static var secondaryTextBlack = UIColor(red: 0, green: 0, blue: 0, alpha:0.54)


    
    static var backgroundLight = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)

    
    static var backgroundDark = UIColor(red:0.19, green:0.19, blue:0.19, alpha:1.0)
}
