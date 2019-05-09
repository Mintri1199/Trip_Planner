//
//  MainTableViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    // TODO: Change this later one when implemented Core Data
    
    var tripStore: TripStore!
    
    var tripViewModels = [TripViewModel](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let reuseIdentifier = "cell"
    
    let floatingButton = FloatingButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        configNavbar()
        setupFloatingButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Save the new items in the Managed Object Context
        tripViewModels = []
        tripStore.saveContext()
        populatePersistent()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tripViewModels.count == 0 {
            setupEmptyView()
        } else {
            self.tableView.restore()
        }
        return tripViewModels.count
    }
    
    // TODO: Change this later one when implemented Core Data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let trip = tripViewModels[indexPath.row]
        cell.textLabel?.text = "Trip to \(trip.name)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tripName = tripViewModels[indexPath.row]
        tripStore.fetchOneTrip(name: tripName.name) { (result) in
            switch result {
            case .success(let trip):
                let detailView = TripDetailViewController()
                detailView.tripStore = tripStore
                detailView.selectedTrip = trip
                detailView.tripName = tripViewModels[indexPath.row].name
                self.navigationController?.pushViewController(detailView, animated: true)
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedTrip = tripViewModels[indexPath.row]
        
            tripStore.fetchOneTrip(name: selectedTrip.name) { (result) in
                switch result {
                case .success(let trip):
                    let context = tripStore.persistentContainer.viewContext
                    context.delete(trip)
                    self.tripViewModels.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    print(error)
                }
            }
            tripStore.saveContext()
            
        }
    }
}
// Views and Navigation
extension MainTableViewController {
    
    // Configure the navBar with buttons and title
    fileprivate func configNavbar() {
        self.title = "Planned Trip"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushToAddVC))
    }
    
    @objc func pushToAddVC() {
        let addVC = AddTripViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    // Set up an Empty View
    private func setupEmptyView() {
        let emptyView = TripEmptyView(frame: self.view.bounds)
        self.tableView.backgroundView = emptyView
        self.tableView.separatorStyle = .none
    }
    
    private func setupFloatingButtons() {
        view.insertSubview(floatingButton, aboveSubview: self.tableView)
        
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            floatingButton.heightAnchor.constraint(equalToConstant: 60),
            floatingButton.widthAnchor.constraint(equalToConstant: 60)
            ])
    }
}

// Core Data function
extension MainTableViewController {
    // Update the tableView's data source
    private func populatePersistent() {
        tripStore.fetchPersistedData { (result) in
            switch result {
            case .success(let listOfTrips):
                for trip in listOfTrips {
                    self.tripViewModels.append(TripViewModel.init(trip: trip))
                }
            case .failure(let error):
                self.tripViewModels.removeAll()
            }
            // reload the table view's data source to present the current data set
            self.tableView.reloadData()
        }
    }
    func deleteTrip(at index: Int) {
        // Delete the user-selected item from the context
        let viewContext = tripStore.persistentContainer.viewContext
        let targetedTripName = tripViewModels[index]
        tripStore.fetchOneTrip(name: targetedTripName.name) { (result) in
            switch result {
            case .success(let trip):
                viewContext.delete(trip)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainTableViewController: CreateTrip {
    func createTrip(tripName: String) {
        // Instantiate new
        let newTrip = NSEntityDescription.insertNewObject(forEntityName: "TripPersistent", into: tripStore.persistentContainer.viewContext) as? TripPersistent
        newTrip?.name = tripName
        if let trip = newTrip {
            tripViewModels.append(TripViewModel.init(trip: trip))
        }
    }
}
