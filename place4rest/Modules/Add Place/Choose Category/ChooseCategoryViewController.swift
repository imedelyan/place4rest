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
        R.string.localizable.headerPrimaryCategory(),
        R.string.localizable.headerCategoryFor()
    ]
    private var categories: [Category] {
        var categories = Category.allCases
        categories.removeLast()
        categories = Array(categories.prefix((categories.count / 2)))
        return categories
    }
    private var selectedCategory: Category = .unknown {
        didSet {
            continueButton.backgroundColor = selectedCategory == .unknown
                ? R.color.light_gray()
                : R.color.green()
            continueButton.isEnabled = selectedCategory != .unknown
        }
    }
    private var selectedCategoryIndexPath = IndexPath()
    private var categoriesFor: [CategoryFor] {
        var categoriesFor = CategoryFor.allCases
        categoriesFor.removeLast()
        categoriesFor = Array(categoriesFor.prefix((categoriesFor.count / 2)))
        return categoriesFor
    }
    private var selectedCategoriesFor: [CategoryFor] = []
    private var place = Place()

    // MARK: - IBAction
    @IBAction func didTapContinueButton(_ sender: Any) {
        place.categories.append(selectedCategory.rawValue)
        place.categoriesFor.append(objectsIn: selectedCategoriesFor.map { $0.rawValue })
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
            if selectedCategoryIndexPath != indexPath {
                tableView.deselectRow(at: selectedCategoryIndexPath, animated: false)
            }
            selectedCategoryIndexPath = indexPath
            selectedCategory = categories[indexPath.row]
        case 1:
            selectedCategoriesFor.append(categoriesFor[indexPath.row])
        default: break
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCategory = .unknown
        case 1:
            guard let index = selectedCategoriesFor.index(of: categoriesFor[indexPath.row]) else { return }
            selectedCategoriesFor.remove(at: index)
        default: break
        }
    }
}
