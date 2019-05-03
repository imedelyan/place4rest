//
//  PhotoCollectionViewCell.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/14/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Kingfisher
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var photoImageView: UIImageView!

    override func prepareForReuse() {
        photoImageView.image = nil
    }

    var imageURLString: String = "" {
        didSet {
            guard let url = URL(string: imageURLString) else { return }
            photoImageView.kf.setImage(with: url)
        }
    }
}
