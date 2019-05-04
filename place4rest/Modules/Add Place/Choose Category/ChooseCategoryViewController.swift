//
//  ChooseCategoriesViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class ChooseCategoryViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        }
    }

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!

    // MARK: - Variables
    private let sectionTitles = [
        "Select one primary category",
        "Select what this category is for"
    ]
    private var categories: [Category] {
        var categories = Category.allCases
        categories.removeLast()
        return categories
    }
    private var selectedCategory: Category = .unknown {
        didSet {
            continueButton.backgroundColor = R.color.green()
            continueButton.isEnabled = true
            place.categories.removeAll()
            place.categories.append(selectedCategory.rawValue)
        }
    }
    private var categoriesFor: [CategoryFor] {
        var categoriesFor = CategoryFor.allCases
        categoriesFor.removeLast()
        return categoriesFor
    }
    private var place = Place()

    // MARK: - IBAction
    @IBAction func didTapContinueButton(_ sender: Any) {
        navigator.navigate(to: .chooseServices(place: place))
    }
}

// MARK: - UITableViewDataSource
extension ChooseCategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categories.count
        case 1:
            return categoriesFor.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                 for: indexPath) as! CategoryTableViewCell
        switch indexPath.section {
        case 0:
            cell.fill(with: categories[indexPath.row])
        case 1:
            cell.fill(with: categoriesFor[indexPath.row])
        default: break
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChooseCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCategory = categories[indexPath.row]
        case 1:
            place.categoriesFor.append(categoriesFor[indexPath.row].rawValue)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCategory = categories[indexPath.row]
        case 1:
            selectedCategoryFor = categoriesFor[indexPath.row]
        default: break
        }
    }
}
