//
//  PlaceCalloutView.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/12/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Kingfisher
import Mapbox
import UIKit

class PlaceCalloutView: UIView, MGLCalloutView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    var representedObject: MGLAnnotation
    var leftAccessoryView: UIView = UIView()
    var rightAccessoryView: UIView = UIView()
    weak var delegate: MGLCalloutViewDelegate?
    var onDetailsTap: (() -> Void)?

    required init(annotation: PlaceAnnotation) {
        representedObject = annotation
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                 size: CGSize(width: UIScreen.main.bounds.width * 0.75,
                                              height: 270.0)))

        commonInit()

        titleLable.text = annotation.title
        if let urlString = annotation.place.featuredImage?.url, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("PlaceCalloutView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        self.center = view.center
        view.addSubview(self)
    }

    func dismissCallout(animated: Bool) {
        removeFromSuperview()
    }

    @IBAction private func didTapDetailsButton(_ sender: Any) {
        onDetailsTap?()
    }
}
