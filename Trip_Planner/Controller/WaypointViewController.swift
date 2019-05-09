//
//  WaypointViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/28/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class WaypointViewController: UIViewController {

    private var selectedWaypoint: Waypoint?
    var trip: TripPersistent?
    private var selectedMapPin: MapViewViewModel?
    private let networkManager = NetworkManager()
    var tripStore: TripStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupMapView()
        configNavbar()
        setupSearchController()
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
            ])
    }
    let searchTableController = SearchResultTableViewController()
    var waypointSearchController: UISearchController? = nil
    
    fileprivate func configNavbar() {
        self.title = "Add Waypoint"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveWaypoint))
    }
    
    fileprivate func setupSearchController() {
        waypointSearchController = UISearchController(searchResultsController: searchTableController)
        waypointSearchController?.obscuresBackgroundDuringPresentation = false
        waypointSearchController?.searchResultsUpdater = searchTableController
        waypointSearchController?.searchBar.placeholder = "Enter Address Here"
        waypointSearchController?.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = waypointSearchController
        searchTableController.delegate = self
        definesPresentationContext = true
    }
}

// All @objc functions
extension WaypointViewController {
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveWaypoint() {
        let context = tripStore.persistentContainer.viewContext
        if let waypoint = selectedWaypoint, let trip = trip {
            let newWaypoint = WaypointPersistent(context: context)
            
            newWaypoint.latitude = waypoint.lat
            newWaypoint.longitude = waypoint.lng
            newWaypoint.name = waypoint.name
            
            trip.addToTrip(newWaypoint)
            tripStore.saveContext()
        } else {
            let alertController = UIAlertController(title: "You didn't select a location ", message: "Search and select a location in order to save", preferredStyle: .alert)
            
            alertController.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension WaypointViewController: ViewWaypointPin {
    func showPin(waypoint: Waypoint) {
        if let existedPin = selectedMapPin {
            mapView.removeAnnotation(existedPin)
        }
        
        selectedWaypoint = waypoint
        selectedMapPin = MapViewViewModel(wayPoint: waypoint)
        
        mapView.addAnnotation(selectedMapPin!)
        let coordinateRegion = MKCoordinateRegion(center: selectedMapPin!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
