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
    @IBOutlet private weak var imageView: UIImageView!

    // MARK: - Dependencies
    var navigator: MapNavigator!
    var presenter: PlacePresenter!

    // MARK: - Variables
    private var props = Props()

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

// MARK: - PlaceView
protocol PlaceView: class {
    func render(props: PlaceViewController.Props)
}

extension PlaceViewController: PlaceView {
    func render(props: Props) {
        self.props = props

    }
}

// MARK: - Props
extension PlaceViewController {
    struct Props {
//        let didTapExpandLayersButton: Command
//        let isLayerViewExpanded: Bool
//        let didTapLocateButton: Command
//        let didTapSearchButton: Command
//        let isSearchBarExpanded: Bool
//        let didReceiveTextForSearch: CommandWith<String>
    }
}
