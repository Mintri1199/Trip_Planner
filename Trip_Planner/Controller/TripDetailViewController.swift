//
//  TripDetailViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/27/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

// This View controller will have a tableView 2/3 of the screen
class TripDetailViewController: UIViewController {
    var tripName: String = ""
    
    var waypointViewModels = [WaypointViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupEmptyView()
        emptyView.getStartedButton.addTarget(self, action: #selector(pushToWaypointVC), for: .touchUpInside)
    }
    
    let emptyView = EmptyWaypointView(frame: UIScreen.main.bounds)
    let tableView = WaypointTableView(frame: .zero)
    let topView = TripDetailTopView(frame: .zero)
    
    private func setupEmptyView() {
        if tableView.superview == self.view {
            tableView.removeFromSuperview()
            topView.removeFromSuperview()
        }
        view.addSubview(emptyView)
    }
    
    private func restore() {
        emptyView.removeFromSuperview()
        setupViews()
    }
    private func setupViews() {
        view.addSubview(topView)
        view.addSubview(tableView)
        topView.titleLabel.text = "\(tripName)"
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2 / 3),
            topView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            ])
    }
}

// All @objc functions
extension TripDetailViewController {
    @objc func pushToWaypointVC() {
        let waypointVC = WaypointViewController()
        waypointVC.delegate = self
        navigationController?.pushViewController(waypointVC, animated: true)
    }
}

extension TripDetailViewController: SavingWaypoint {
    func save() {
        restore()
    }
}
