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
    @IBOutlet private weak var layersVEView: VisualEffectView!
    @IBOutlet private weak var layersVEViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var layersVEViewWidth: NSLayoutConstraint!

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
        mapView.styleURL = MGLStyle.satelliteStyleURL
        mapView.compassView.isHidden = true
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true

        addAnnotation(coordinates: CLLocationCoordinate2D(latitude: 52.397519, longitude: 16.899333))

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressOnMap))
        mapView.addGestureRecognizer(longPressRecognizer)
    }

    // MARK: - IBAction
    @IBAction private func layersButtonAction(_ sender: Any) {
        layersVEView.layoutIfNeeded()
        if self.layersVEViewHeight.constant == 178 {
            self.layersVEViewHeight.constant = 46
            self.layersVEViewWidth.constant = 46
        } else {
            self.layersVEViewHeight.constant = 178
            self.layersVEViewWidth.constant = 178
        }

        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
            self.layersVEView.layoutIfNeeded()
        }
        animator.startAnimation()
    }

    @IBAction private func locateButtonAction(_ sender: Any) {
        mapView.setCenter((mapView.userLocation?.coordinate)!, zoomLevel: 7, animated: true)
    }

    @IBAction private func searchButtonAction(_ sender: Any) {

    }

    @IBAction private func filterButtonAction(_ sender: Any) {

    }

    // MARK: - Anotations
    func addAnnotation(coordinates: CLLocationCoordinate2D) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "place4rest"
        annotation.subtitle = "Hello!"

        mapView.addAnnotation(annotation)
    }

    @objc func longPressOnMap(_ recognizer: UILongPressGestureRecognizer) {
        let longPressScreenCoordinates = recognizer.location(in: mapView)
        let longPressMapCoordinates = mapView.convert(longPressScreenCoordinates, toCoordinateFrom: mapView)

        addAnnotation(coordinates: longPressMapCoordinates)
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

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        mapView.setCenter((mapView.userLocation?.coordinate)!, zoomLevel: 4, animated: true)
    }
}
