//
//  TripLabel.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class TripLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        text = "Give this trip a name!"
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 20
        
        font = UIFont(name: "Helvetica", size: 40)
        
        // Adjust the font size dynamically
        minimumScaleFactor = 0.5
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
