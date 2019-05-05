//
//  CategoryTableViewCell.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var lineView: UIView!

    func fill(with category: ImagePresentable) {
        titleLabel.text = category.name
        categoryImageView.image = category.image
        categoryImageView.tintColor = category.color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = selected ? R.color.light_gray() : .white
        lineView.backgroundColor = selected ? R.color.dark_gray() : R.color.light_gray()
    }
}
