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
        "Select one or more secondary categories",
        "Select one or more facilities",
        "Select one or more activities"
    ]
    private var categories: [Category] {
        var categories = Category.allCases
        categories.removeLast()
        return categories
    }
    private var services: [Service] {
        var services = Service.allCases
        services.removeLast()
        return services
    }
    private var activities: [Activity] {
        var activities = Activity.allCases
        activities.removeLast()
        return activities
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBAction
    @IBAction func didTapContinueButton(_ sender: Any) {
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
            place.categories.append(categories[indexPath.row].rawValue)
        case 1:
            place.services.append(services[indexPath.row].rawValue)
        case 2:
            place.activities.append(activities[indexPath.row].rawValue)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            place.categories.removeFirst(where: { $0 == categories[indexPath.row].rawValue })
        case 1:
            choosedService = services[indexPath.row]
        case 2:
            choosedActivity = activities[indexPath.row]
        default: break
        }
    }
}
