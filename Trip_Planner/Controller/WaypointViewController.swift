//
//  WaypointViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/28/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import MapKit

protocol SavingWaypoint {
    func save()
}

class WaypointViewController: UIViewController {

    var delegate: SavingWaypoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupMapView()
        configNavbar()
    }
    
    var mapView: MKMapView = {
        var mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private func setupMapView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2 / 3)
            ])
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate func configNavbar() {
        self.title = "Add Waypoint"
        
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter Address Here"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveWaypoint))
    }
}

// All @objc functions
extension WaypointViewController {
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveWaypoint() {
        print("saveButton Tapped")
        delegate?.save()
        navigationController?.popViewController(animated: true)
    }
    
}
