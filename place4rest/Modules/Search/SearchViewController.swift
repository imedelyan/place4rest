//
//  SearchViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/1/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!

    // MARK: - Dependencies
    var navigator: SearchNavigator!
    var presenter: SearchPresenter!

    // MARK: - Variables
    private var props = Props(
        didReceiveTextForSearch: .nop,
        foundPlaces: []
    )

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presenter.viewWasLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UISearchBarDelegate {
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
        cell.textLabel?.text = props.foundPlaces[indexPath.row].title.withoutHtml
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        navigator.navigate(to: .place(props.foundPlaces[indexPath.row]))
    }
}

// MARK: - MapView
protocol SearchView: class {
    func render(props: SearchViewController.Props)
}

extension SearchViewController: SearchView {
    func render(props: Props) {
        self.props = props
        searchTableView.reloadData()
    }
}

// MARK: - Props
extension SearchViewController {
    struct Props {
        let didReceiveTextForSearch: CommandWith<String>
        let foundPlaces: [Place]
    }
}
