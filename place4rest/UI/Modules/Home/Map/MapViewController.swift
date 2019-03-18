//
//  MapViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Mapbox
import UIKit

class MapViewController: UIViewController, MapView {

    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: MGLMapView!
    @IBOutlet private weak var layersVEView: VisualEffectView!
    @IBOutlet private weak var layersVEViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var layersVEViewWidth: NSLayoutConstraint!

    // MARK: - Dependencies
    var presenter: MapPresenter!

    // MARK: - Variables
    var props: MapViewController.Props = .init(mapItems: [],
                                               layersButtonAction: .nop,
                                               locateButtonAction: .nop,
                                               searchButtonAction: .nop,
                                               filterButtonAction: .nop,
                                               filterType: .allPlaces,
                                               layerType: .satellite,
                                               userLocation: .notSet,
                                               currentLocation: .notSet,
                                               visibleCoordinateBounds: MGLCoordinateBounds())
    private let mapStyles: [URL?] = [
        MGLStyle.streetsStyleURL,
        URL(string: "mapbox://styles/imedelian/cjs3aet6z19qe1ft85b2xva57"),
        MGLStyle.satelliteStyleURL
    ]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.compassView.isHidden = true
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        mapView.delegate = presenter

        presenter.viewWasLoaded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        show(places: props.mapItems)
        if mapView.styleURL != mapStyles[props.layerType.rawValue] {
            mapView.styleURL = mapStyles[props.layerType.rawValue]
        }
        mapView.setCenter(props.currentLocation.coordinate, zoomLevel: props.currentLocation.zoomLevel, animated: true)
    }

    func render(props: Props) {
        self.props = props
        self.view.setNeedsLayout()
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
        props.locateButtonAction.perform()
    }

    @IBAction private func searchButtonAction(_ sender: Any) {

        props.searchButtonAction.perform(with: "Test")
    }

    @IBAction private func filterButtonAction(_ sender: Any) {

        props.filterButtonAction.perform(with: .allPlaces)
    }

    // MARK: - Anotations
    private func show(places: [Props.MapItem]) {
        places.forEach { addAnnotation(for: $0.place) }
    }

    private func addAnnotation(for place: Place) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        annotation.title = place.title
//        annotation.subtitle = place.title
        mapView.addAnnotation(annotation)
    }

    private func addAnnotation(coordinates: CLLocationCoordinate2D) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "New Place"
//        annotation.subtitle = "Hello!"
        mapView.addAnnotation(annotation)
    }
}

// MARK: - MapView
protocol MapView: class {
    func render(props: MapViewController.Props)
}

// MARK: - Props
extension MapViewController {
    struct Props {
        let mapItems: [MapItem]
        let layersButtonAction: CommandWith<LayerType>
        let locateButtonAction: Command
        let searchButtonAction: CommandWith<String>
        let filterButtonAction: CommandWith<FilterType>
        let filterType: FilterType
        let layerType: LayerType
        let userLocation: CameraLocation
        let currentLocation: CameraLocation
        let visibleCoordinateBounds: MGLCoordinateBounds

        struct MapItem {
            let place: Place
            let select: Command
        }

        enum FilterType {
            case hostel
            case wildPlace
            case allPlaces
        }

        enum LayerType: Int {
            case street
            case terrain
            case satellite
        }

        struct CameraLocation {
            let coordinate: CLLocationCoordinate2D
            let zoomLevel: Double

            static var notSet: CameraLocation {
                return CameraLocation(coordinate: CLLocationCoordinate2D(), zoomLevel: 0)
            }
        }
    }
}
