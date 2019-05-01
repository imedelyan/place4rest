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
    @IBOutlet private weak var filterMenuTrailing: NSLayoutConstraint!
    @IBOutlet private weak var wildPlaceFilterButton: UIButton!
    @IBOutlet private weak var parkingFilterButton: UIButton!
    @IBOutlet private weak var campingFilterButton: UIButton!
    @IBOutlet private weak var sedanFilterButton: UIButton!
    @IBOutlet private weak var trailerFilterButton: UIButton!

    // MARK: - Dependencies
    var navigator: MapNavigator!
    var presenter: MapPresenter!

    // MARK: - Variables
    private var props = Props(
        places: [],
        didTapExpandLayersButton: .nop,
        didTapLayersButton: .nop,
        isLayerViewExpanded: false,
        layerType: .satellite,
        didTapLocateButton: .nop,
        didTapSearchButton: .nop,
        didTapFilterButton: .nop,
        didChooseCategoryFilter: .nop,
        categoryFilters: [],
        didChooseCategoryForFilter: .nop,
        categoryForFilters: [],
        isFilterMenuExpanded: false,
        userLocation: .notSet,
        currentLocation: .notSet,
        visibleCoordinateBounds: MGLCoordinateBounds()
    )
    private let mapStyles: [URL?] = [
        MGLStyle.streetsStyleURL,
        URL(string: "mapbox://styles/imedelian/cjs3aet6z19qe1ft85b2xva57"),
        MGLStyle.satelliteStyleURL
    ]
    private var placeAnnotations: [PlaceAnnotation] = []

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""

        mapView.compassView.isHidden = true
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true
        mapView.delegate = presenter

        presenter.viewWasLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        props.didTapFilterButton.perform()
    }

    // MARK: - Filter Menu IBActions
    @IBAction private func wildPlaceFilterButtonAction(_ sender: Any) {
        props.didChooseCategoryFilter.perform(with: .wildnights)
    }

    @IBAction private func parkingFilterButtonAction(_ sender: Any) {
        props.didChooseCategoryFilter.perform(with: .nightparking)
    }

    @IBAction private func campingFilterButtonAction(_ sender: Any) {
        props.didChooseCategoryFilter.perform(with: .camping)
    }

    @IBAction private func sedanFilterButtonAction(_ sender: Any) {
        props.didChooseCategoryForFilter.perform(with: .cars)
    }

    @IBAction private func trailerFilterButtonAction(_ sender: Any) {
        props.didChooseCategoryForFilter.perform(with: .motorhome)
    }

    // MARK: - Anotations
    private func show(places: [Place]) {
        places.forEach { addPlaceAnnotation(for: $0) }
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
        placeAnnotations.append(annotation)
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
    func show(place: Place)
    func showSearch()
}

extension MapViewController: MapView {
    func render(props: Props) {
        // show places
        if self.props.places != props.places {
            mapView.removeAnnotations(placeAnnotations)
            placeAnnotations = []
            show(places: props.places)
        }

        self.props = props

        layersVEView.layoutIfNeeded()

        // set layer style
        if mapView.styleURL != mapStyles[props.layerType.rawValue] {
            mapView.styleURL = mapStyles[props.layerType.rawValue]
        }

        // set layers view expanded size
        self.layersVEViewHeight.constant = props.isLayerViewExpanded ? 170 : 46
        self.layersVEViewWidth.constant = props.isLayerViewExpanded ? 130 : 46

        // set map position
        mapView.setCenter(props.currentLocation.coordinate, zoomLevel: props.currentLocation.zoomLevel, animated: true)

        // show/hide filter menu
        self.filterMenuTrailing.constant = props.isFilterMenuExpanded ? 0 : -80

        // tinting filter menu buttons
        // TODO: move it to UIButton subclass
        wildPlaceFilterButton.tintColor = props.categoryFilters.contains(.wildnights) ? R.color.blue() : R.color.light_gray()
        parkingFilterButton.tintColor = props.categoryFilters.contains(.nightparking) ? R.color.blue() : R.color.light_gray()
        campingFilterButton.tintColor = props.categoryFilters.contains(.camping) ? R.color.blue() : R.color.light_gray()
        sedanFilterButton.tintColor = props.categoryForFilters.contains(.cars) ? R.color.orange() : R.color.light_gray()
        trailerFilterButton.tintColor = props.categoryForFilters.contains(.motorhome) ? R.color.orange() : R.color.light_gray()

        // animation
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    func show(place: Place) {
        navigator.navigate(to: .place(place))
    }

    func showSearch() {
        navigator.navigate(to: .search)
    }
}

// MARK: - Props
extension MapViewController {
    struct Props {
        let places: [Place]
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
        let didTapFilterButton: Command
        let didChooseCategoryFilter: CommandWith<Category>
        let categoryFilters: Set<Category>
        let didChooseCategoryForFilter: CommandWith<CategoryFor>
        let categoryForFilters: Set<CategoryFor>
        let isFilterMenuExpanded: Bool
        let userLocation: CameraLocation
        let currentLocation: CameraLocation
        let visibleCoordinateBounds: MGLCoordinateBounds

        struct CameraLocation {
            let coordinate: CLLocationCoordinate2D
            let zoomLevel: Double

            static var notSet: CameraLocation {
                return CameraLocation(coordinate: CLLocationCoordinate2D(), zoomLevel: 0)
            }
        }
    }
}
