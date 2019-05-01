//
//  SearchViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/1/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UITextFieldDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard searchBarWidth.constant == 48 else { return true }
        searchBarWidth.constant = view.frame.width - 141
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        searchBarWidth.constant = 48
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        props.didReceiveTextForSearch.perform(with: searchBar.text!)
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.foundPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTitleCell", for: indexPath)
        cell.textLabel?.text = props.foundPlaces[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        show(place: props.foundPlaces[indexPath.row])
    }
}
