//
//  WaypointTableView.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/27/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class WaypointTableView: UITableView {
    
    let resuseIdentifier = "Waypoint Cell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        register(UITableViewCell.self, forCellReuseIdentifier: resuseIdentifier)
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WaypointTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let detailVC = findViewController() as? TripDetailViewController else { return 0 }
        return detailVC.waypointViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: resuseIdentifier, for: indexPath)
        return cell
    }
}
