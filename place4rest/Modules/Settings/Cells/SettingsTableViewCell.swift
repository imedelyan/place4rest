//
//  SettingsTableViewCell.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/6/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!

    var title: String {
        set { titleLabel.text = newValue }
        get { return titleLabel.text ?? "" }
    }
}
