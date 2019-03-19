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
    var presenter: MapPresenter!

    // MARK: - Variables
    private var props = Props(
        mapItems: [],
        layersButtonAction: .nop,
        locateButtonAction: .nop,
        searchButtonAction: .nop,
        filterButtonAction: .nop,
        filterType: .allPlaces,
        layerType: .satellite,
        userLocation: .notSet,
        currentLocation: .notSet,
        visibleCoordinateBounds: MGLCoordinateBounds(),
        searchText: ""
    )
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
        mapView.addAnnotation(annotation)
    }

    private func addAnnotation(coordinates: CLLocationCoordinate2D) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "New Place"
        mapView.addAnnotation(annotation)
    }
}

// MARK: - MapView
protocol MapView: class {
    func render(props: MapViewController.Props)
}

extension MapViewController: MapView {
    func render(props: Props) {
        self.props = props
        self.view.setNeedsLayout()
    }
}

// MARK: - Props
extension MapViewController {
    struct Props {
        let mapItems: [MapItem]
        let layersButtonAction: CommandWith<LayerType>
        let locateButtonAction: Command
        let searchButtonAction: CommandWith<String>
        let filterButtonAction: CommandWith<FilterType>
        let filterType: FilterType; enum FilterType {
            case hostel
            case wildPlace
            case allPlaces
        }
        let layerType: LayerType; enum LayerType: Int {
            case street
            case terrain
            case satellite
        }
        let userLocation: CameraLocation
        let currentLocation: CameraLocation
        let visibleCoordinateBounds: MGLCoordinateBounds
        let searchText: String

        struct MapItem {
            let place: Place
            let select: Command
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
