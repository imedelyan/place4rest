//
//  ChooseLocationViewController.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/4/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Mapbox
import UIKit

class ChooseLocationViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: MGLMapView!
    @IBOutlet private weak var layersVEView: VisualEffectView!
    @IBOutlet private weak var layersVEViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var layersVEViewWidth: NSLayoutConstraint!

    // MARK: - Dependencies
    var navigator: AddPlaceNavigator!
    var place = Place()

    // MARK: - Variables
    private let streetsStyleURL = MGLStyle.streetsStyleURL
    private let terrainStyleURL = URL(string: "mapbox://styles/imedelian/cjs3aet6z19qe1ft85b2xva57")
    private let satelliteStyleURL = MGLStyle.satelliteStyleURL
    private var isLayerViewExpanded = false

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.compassView.isHidden = true
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        mapView.delegate = self
    }

    private func toggleExpandedLayersState() {
        layersVEView.layoutIfNeeded()
        isLayerViewExpanded.toggle()
        layersVEViewHeight.constant = isLayerViewExpanded ? 170 : 46
        layersVEViewWidth.constant = isLayerViewExpanded ? 130 : 46
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - IBAction
    @IBAction func didTapContinueButton(_ sender: Any) {
        place.latitude = mapView.centerCoordinate.latitude
        place.longitude = mapView.centerCoordinate.longitude
        navigator.navigate(to: .addInfo(place: place))
    }

    @IBAction private func layersButtonAction(_ sender: Any) {
        toggleExpandedLayersState()
    }

    @IBAction func didTapTerrainStyleButton(_ sender: Any) {
        toggleExpandedLayersState()
        guard mapView.styleURL != terrainStyleURL else { return }
        mapView.styleURL = terrainStyleURL
    }

    @IBAction func didTapStreetStyleButton(_ sender: Any) {
        toggleExpandedLayersState()
        guard mapView.styleURL != streetsStyleURL else { return }
        mapView.styleURL = streetsStyleURL
    }

    @IBAction func didTapSatelliteStyleButton(_ sender: Any) {
        toggleExpandedLayersState()
        guard mapView.styleURL != satelliteStyleURL else { return }
        mapView.styleURL = satelliteStyleURL
    }

    @IBAction private func locateButtonAction(_ sender: Any) {
        guard let location = mapView.userLocation, location.coordinate.latitude > -180 else { return }
        mapView.setCenter(location.coordinate, zoomLevel: 10, animated: true)
    }
}

// MARK: - MGLMapViewDelegate
extension ChooseLocationViewController: MGLMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        guard let location = mapView.userLocation, location.coordinate.latitude > -180 else { return }
        mapView.setCenter(location.coordinate, zoomLevel: 4, animated: true)
    }
}
