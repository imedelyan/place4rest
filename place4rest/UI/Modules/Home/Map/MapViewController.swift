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
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchBarWidth: NSLayoutConstraint!

    // MARK: - Dependencies
    var presenter: MapPresenter!

    // MARK: - Variables
    private var props = Props(
        mapItems: [],
        didTapExpandLayersButton: .nop,
        didTapLayersButton: .nop,
        isLayerViewExpanded: false,
        layerType: .satellite,
        didTapLocateButton: .nop,
        didTapSearchButton: .nop,
        isSearchBarExpanded: false,
        didReceiveTextForSearch: .nop,
        didTapFilterButton: .nop,
        filterType: .allPlaces,
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

    // MARK: - IBAction
    @IBAction private func layersButtonAction(_ sender: Any) {
        props.didTapExpandLayersButton.perform()
    }

    @IBAction func didTapTerrainStyleButton(_ sender: Any) {
        props.didTapLayersButton.perform(with: .terrain)
    }

    @IBAction func didTapStreetStyleButton(_ sender: Any) {
        props.didTapLayersButton.perform(with: .street)
    }

    @IBAction func didTapSatelliteStyleButton(_ sender: Any) {
        props.didTapLayersButton.perform(with: .satellite)
    }

    @IBAction private func locateButtonAction(_ sender: Any) {
        props.didTapLocateButton.perform()
    }

    @IBAction private func searchButtonAction(_ sender: Any) {
        props.didTapSearchButton.perform()
    }

    @IBAction private func filterButtonAction(_ sender: Any) {

        props.didTapFilterButton.perform(with: .allPlaces)
    }

    // MARK: - Anotations
    private func show(places: [Props.MapItem]) {
        places.forEach { addPlaceAnnotation(for: $0.place) }
    }

    private func addAnnotation(for place: Place) {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        annotation.title = place.title
        mapView.addAnnotation(annotation)
    }

    private func addPlaceAnnotation(for place: Place) {
        let annotation = PlaceAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        annotation.title = place.title
        annotation.subtitle = place.content
        annotation.willUseImage = true
        annotation.place = place
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

        layersVEView.layoutIfNeeded()

        // show places
        show(places: props.mapItems)

        // set layer style
        if mapView.styleURL != mapStyles[props.layerType.rawValue] {
            mapView.styleURL = mapStyles[props.layerType.rawValue]
        }

        // set layers view expanded size
        self.layersVEViewHeight.constant = props.isLayerViewExpanded ? 170 : 46
        self.layersVEViewWidth.constant = props.isLayerViewExpanded ? 130 : 46

        // set map position
        mapView.setCenter(props.currentLocation.coordinate, zoomLevel: props.currentLocation.zoomLevel, animated: true)

        // set search bar expanded size
        searchBarWidth.constant = props.isSearchBarExpanded ? view.frame.width - 195 : 0

        // animation
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Props
extension MapViewController {
    struct Props {
        let mapItems: [MapItem]
        let didTapExpandLayersButton: Command
        let didTapLayersButton: CommandWith<LayerType>
        let isLayerViewExpanded: Bool
        let layerType: LayerType; enum LayerType: Int {
            case street
            case terrain
            case satellite
        }
        let didTapLocateButton: Command
        let didTapSearchButton: Command
        let isSearchBarExpanded: Bool
        let didReceiveTextForSearch: CommandWith<String>
        let didTapFilterButton: CommandWith<FilterType>
        let filterType: FilterType; enum FilterType {
            case hostel
            case wildPlace
            case allPlaces
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
