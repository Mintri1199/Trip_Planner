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
    
    let floatingButton = FloatingButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        configNavbar()
        setupFloatingButtons()
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
        let detailView = TripDetailViewController()
        detailView.tripName = tripViewModels[indexPath.row].name
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tripViewModels.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
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

extension MainTableViewController: CreateTrip {
    // TODO: Change this later one when implemented Core Data
    func createTrip(tripName: String) {
        tripViewModels.append(TripViewModel.init(trip: Trip(name: tripName)))
    }
}
