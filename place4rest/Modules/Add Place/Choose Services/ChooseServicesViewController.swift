//
//  ChooseServicesViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class ChooseServicesViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        }
    }

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!
    var place = Place()

    // MARK: - Variables
    private let sectionTitles = [
        R.string.localizable.headerSecondatyCategories(),
        R.string.localizable.headerFacilities(),
        R.string.localizable.headerActivities()
    ]
    private var categories: [Category] {
        var categories: [Category] = Category.allCases
        categories.removeLast()
        guard
            let mainCategoryValue = place.categories.first,
            let mainCategory = Category(rawValue: mainCategoryValue),
            let index = categories.index(of: mainCategory) else {
            return categories
        }
        categories.remove(at: index)
        return categories
    }
    private var selectedCategories: [Category] = []
    private var services: [Service] {
        var services = Service.allCases
        services.removeLast()
        return services
    }
    private var selectedServices: [Service] = []
    private var activities: [Activity] {
        var activities = Activity.allCases
        activities.removeLast()
        return activities
    }
    private var selectedActivities: [Activity] = []

    // MARK: - IBAction
    @IBAction func didTapContinueButton(_ sender: Any) {
        place.categories.append(objectsIn: selectedCategories.map { $0.rawValue })
        place.services.append(objectsIn: selectedServices.map { $0.rawValue })
        place.activities.append(objectsIn: selectedActivities.map { $0.rawValue })
        navigator.navigate(to: .chooseLocation(place: place))
    }
}

// MARK: - UITableViewDataSource
extension ChooseServicesViewController: UITableViewDataSource {
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
            return services.count
        case 2:
            return activities.count
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
            cell.fill(with: services[indexPath.row])
        case 2:
            cell.fill(with: activities[indexPath.row])
        default: break
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChooseServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCategories.append(categories[indexPath.row])
        case 1:
            selectedServices.append(services[indexPath.row])
        case 2:
            selectedActivities.append(activities[indexPath.row])
        default: break
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let index = selectedCategories.index(of: categories[indexPath.row]) else { return }
            selectedCategories.remove(at: index)
        case 1:
            guard let index = selectedServices.index(of: services[indexPath.row]) else { return }
            selectedServices.remove(at: index)
        case 2:
            guard let index = selectedActivities.index(of: activities[indexPath.row]) else { return }
            selectedActivities.remove(at: index)
        default: break
        }
    }
}
