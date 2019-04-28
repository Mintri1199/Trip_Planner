//
//  MainTableViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    // TODO: Change this later one when implemented Core Data
    
    var tripViewModels = [TripViewModel](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var listOfTrip: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.isEditing = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        configNavbar()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tripViewModels.count
    }
    // TODO: Change this later one when implemented Core Data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let trip = tripViewModels[indexPath.row]
        cell.textLabel?.text = "Trip to \(trip.name)"
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tripViewModels.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    /*
    // Override to support editing the table view.
    // Make sure to delete the planned trip from core data and firebase
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
}
// Navbar and navigation
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
    
}

extension MainTableViewController: CreateTrip {
    // TODO: Change this later one when implemented Core Data
    func createTrip(tripName: String) {
        tripViewModels.append(TripViewModel.init(trip: Trip(name: tripName)))
    }
}
