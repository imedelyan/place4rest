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

    override func prepareForReuse() {
        imageView.image = nil
    }

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
}
