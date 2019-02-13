//
//  MapViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Mapbox
import UIKit

class MapViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: MGLMapView!

    // MARK: - Dependencies
//    var presenter:

    // MARK: - Variables
    private let mapStyles: [URL?] = [
        MGLStyle.streetsStyleURL,
        URL(string: "mapbox://styles/imedelian/cjs3aet6z19qe1ft85b2xva57"),
        MGLStyle.satelliteStyleURL
    ]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setCenter(CLLocationCoordinate2D(latitude: 52.397519, longitude: 16.899333), zoomLevel: 5, animated: false)
        addAnnotation()
    }

    // MARK: - IBAction
    @IBAction private func layersButtonAction(_ sender: Any) {
        mapView.styleURL = mapStyles[[0, 1, 2].randomElement()!]
    }

    @IBAction private func locateButtonAction(_ sender: Any) {

    }

    @IBAction private func searchButtonAction(_ sender: Any) {

    }

    @IBAction private func filterButtonAction(_ sender: Any) {

    }

    // MARK: - Anotations
    func addAnnotation() {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 52.397519, longitude: 16.899333)
        annotation.title = "place4rest"
        annotation.subtitle = "Hello!"

        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, acrossDistance: 4500, pitch: 15, heading: 180)
        mapView.fly(to: camera, withDuration: 4,
                    peakAltitude: 3000, completionHandler: nil)
    }
}
