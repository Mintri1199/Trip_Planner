//
//  TripNameTextField.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class TripNameTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        autocorrectionType = .yes
        font = UIFont(name: "Helvetica", size: 20)
        placeholder = "Enter Trip Name"
        
        // Adjust the font size dynamically
        minimumFontSize = 14
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        keyboardType = .alphabet
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
