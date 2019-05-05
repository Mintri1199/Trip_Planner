//
//  FloatingButton.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    
    let xPoint = UIScreen.main.bounds.width * 0.6
    let yPoint = UIScreen.main.bounds.height * 0.8
 
    var lightMode = true  // A flag to indicate light mode or dark mode
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkGray
        
        setTitle("Light", for: .normal)
        setTitleColor(.white, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3.0
        addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Switch color when tapped
    @objc func colorButtonTapped() {
        lightMode = !lightMode
        
        if lightMode {
            UIView.animate(withDuration: 0.5) {
                self.backgroundColor = .white
                self.setTitle("Dark", for: .normal)
                self.setTitleColor(.black, for: .normal)
                self.layer.borderColor = UIColor.darkGray.cgColor
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.backgroundColor = .darkGray
                self.setTitle("Light", for: .normal)
                self.setTitleColor(.white, for: .normal)
                self.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}
