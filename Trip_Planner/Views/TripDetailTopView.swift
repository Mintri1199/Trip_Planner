//
//  TripDetailTopView.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/28/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class TripDetailTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupConstraints()
        setTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let getStartedButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add more waypoints", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            getStartedButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            getStartedButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
    func setTheme() {
        let bool = UserDefaults.standard.bool(forKey: "theme")
        let theme = bool ? ColorTheme.dark : ColorTheme.light
        
        titleLabel.textColor = theme.primaryTextColor
        getStartedButton.setTitleColor(theme.secondaryTextColor, for: .normal)
        backgroundColor = theme.viewControllerBackgroundColor
    }
}
