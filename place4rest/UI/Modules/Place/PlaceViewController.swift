//
//  PlaceViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/13/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    @IBOutlet private weak var textLabel: UILabel!

    // MARK: - Dependencies
    var navigator: MapNavigator!
    var presenter: PlacePresenter!

    // MARK: - Variables
    private var props = Props(
        title: "",
        images: [],
        categories: [],
        text: ""
    )

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewWasLoaded()
    }

    // MARK: - IBAction
    @IBAction private func didTapButton(_ sender: Any) {
//        props.didTapButton.perform()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PlaceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoCollectionView {
           return collectionView.frame.size
        } else {
            return CGSize(width: 40.0, height: 40.0)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PlaceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return props.images.count
        } else {
            return props.categories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
            cell.imageURLString = props.images[indexPath.row].url
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
            cell.image = props.categories[indexPath.row].image
            return cell
        }
    }
}

// MARK: - UIScrollViewDelegate
extension PlaceViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == photoCollectionView else { return }
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

// MARK: - PlaceView
protocol PlaceView: class {
    func render(props: PlaceViewController.Props)
}

extension PlaceViewController: PlaceView {
    func render(props: Props) {
        self.props = props

        titleLabel.text = props.title
        pageControl.numberOfPages = props.images.count
        photoCollectionView.reloadData()
        categoriesCollectionView.reloadData()
        textLabel.text = props.text
    }
}

// MARK: - Props
extension PlaceViewController {
    struct Props {
        let title: String
        let images: [Image]
        let categories: [ImagePresentable]
        let text: String
    }
}

protocol ImagePresentable {
    var image: UIImage { get }
}
