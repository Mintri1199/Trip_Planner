//
//  SearchResultTableViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 5/9/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import MapKit
protocol ViewWaypointPin {
    func showPin(waypoint: Waypoint)
}
class SearchResultTableViewController: UITableViewController {
    var autoCompleteResult: [Waypoint] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var delegate: ViewWaypointPin?
    private let resuseID = "resultCell"
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: resuseID)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if autoCompleteResult.isEmpty {
            return 0
        } else {
            return autoCompleteResult.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resuseID, for: indexPath)
        print(autoCompleteResult.count)
        let waypoint = autoCompleteResult[indexPath.row]
        cell.textLabel?.text = waypoint.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWaypoint = autoCompleteResult[indexPath.row]
        delegate?.showPin(waypoint: selectedWaypoint)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchResultTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        requestAutoComplete(searchText: searchText)
    }
}

extension SearchResultTableViewController {
    private func requestAutoComplete(searchText: String) {
        networkManager.getAutoCompleteResult(input: searchText, completion: { (result) in
            switch result {
            case .success(let addresses):
                self.autoCompleteResult = []
                for address in addresses {
                    self.getGeocode(address: address)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func getGeocode(address: String) {
        networkManager.getGeocode(address: address) { (result) in
            switch result {
            case .success(let model):
                self.autoCompleteResult.append(Waypoint(jsonresult: model))
            case.failure(let error):
                print(error)
            }
        }
    }

}
