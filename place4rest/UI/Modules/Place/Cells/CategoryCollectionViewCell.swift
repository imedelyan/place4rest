//
//  CategoryCollectionViewCell.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    var image: UIImage?
    var color: UIColor?

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.tintColor = color
        imageView.image = image
    }
}
