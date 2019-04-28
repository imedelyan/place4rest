//
//  MapPresenter.swift
//  place4rest
//
//  Created by Igor Medelian on 2/19/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Mapbox
import PromiseKit

final class MapPresenter: NSObject {

    typealias Props = MapViewController.Props

    // MARK: - Dependencies
    private let placesService: PlacesService
    weak var view: MapView!

    // MARK: - Variables
    private var places: [Place] = []
    private var categoryFilters: Set<Category> = []
    private var categoryForFilters: Set<CategoryFor> = []
    private var layerType: Props.LayerType = .satellite
    private var isLayerViewExpanded: Bool = false
    private var isSearchBarExpanded: Bool = false
    private var isFilterMenuExpanded: Bool = false
    private var userLocation: Props.CameraLocation = .notSet
    private var currentLocation: Props.CameraLocation = .notSet
    private var visibleCoordinateBounds = MGLCoordinateBounds()
    private var searchText = ""

    // MARK: - Init
    init(placesService: PlacesService) {
        self.placesService = placesService
    }

    // MARK: - MapView
    func viewWasLoaded() {
        // TODO: show activity indicator
        placesService
            .getAllPlaces()
            .done { [weak self] in
                self?.places = $0
            }.catch { error in
                debugPrint(error.localizedDescription)
            }.finally { [weak self] in
                guard let self = self else { return }
                self.view.render(props: self.makeProps())
        }
    }

    private func filterPlaces() {
        // TODO: show activity indicator
        placesService
            .getPlaces(categories: Array(categoryFilters), for: Array(categoryForFilters))
            .done { [weak self] in
                self?.places = $0
            }.catch { error in
                debugPrint(error.localizedDescription)
            }.finally { [weak self] in
                guard let self = self else { return }
                self.view.render(props: self.makeProps())
        }
    }
}

// MARK: - MGLMapViewDelegate
extension MapPresenter: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {

        let coordinate = CLLocationCoordinate2D(
            latitude: annotation.coordinate.latitude + 0.011, // TODO: change by screen/view size
            longitude: annotation.coordinate.longitude
        )

        let camera = MGLMapCamera(lookingAtCenter: coordinate, acrossDistance: 10000, pitch: 15, heading: 0)
        mapView.fly(to: camera, withDuration: 3, peakAltitude: 10000) { [weak self] in
            self?.currentLocation = Props.CameraLocation(coordinate: coordinate, zoomLevel: mapView.zoomLevel)
        }
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        guard let location = mapView.userLocation, location.coordinate.latitude > -180 else { return }
        userLocation = Props.CameraLocation(coordinate: location.coordinate, zoomLevel: 4)
        currentLocation = userLocation
        view?.render(props: makeProps())
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        currentLocation = Props.CameraLocation(coordinate: mapView.centerCoordinate, zoomLevel: mapView.zoomLevel)
    }

    // This delegate method is where you tell the map to load a view for a specific
    // annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {

        guard let castAnnotation = annotation as? PlaceAnnotation, !castAnnotation.willUseImage else { return nil }

        // TODO: verify if MGLAnnotationView is needed at all

        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
        let reuseIdentifier = "placeView"

        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView!.backgroundColor = UIColor(red: 0.03, green: 0.80, blue: 0.69, alpha: 1.0)
        }

        return annotationView
    }

    // This delegate method is where you tell the map to load an image for a specific
    // annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {

        guard let placeAnnotation = annotation as? PlaceAnnotation, placeAnnotation.willUseImage else { return nil }

        guard let category = placeAnnotation.place.categories.first else { return nil }
        var identifier = "car"
        var image = R.image.car()!
        switch category {
        case 4: // wildnights
            identifier = "tree"
            image = R.image.tree()!
        case 6: // castles
            identifier = "castle"
            image = R.image.castle()!
        case 5: // springs
            identifier = "fontain"
            image = R.image.fontain()!
        case 76: // nightparking
            identifier = "car"
            image = R.image.car()!
        case 72: // camping
            identifier = "car"
            image = R.image.car()!
        default: break
        }
        // For better performance, always try to reuse existing annotations.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: identifier)
        // If there is no reusable annotation image available, initialize a new one.
        if annotationImage == nil {
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: identifier)
        }
        return annotationImage
    }

    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        guard let placeAnnotation = annotation as? PlaceAnnotation, placeAnnotation.willUseImage else { return nil }

        let calloutView = PlaceCalloutView(annotation: placeAnnotation)
        calloutView.onDetailsTap = { [weak self] in
            mapView.deselectAnnotation(annotation, animated: true)
            self?.view.show(place: placeAnnotation.place)
        }
        return calloutView
    }

    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        mapView.deselectAnnotation(annotation, animated: true)
    }
}

// MARK: - Props Factory
extension MapPresenter {
    private func makeProps() -> Props {
        return Props(places: places,
                     didTapExpandLayersButton: Command(action: { [weak self] in
                        guard let self = self else { return }
                        self.isLayerViewExpanded.toggle()
                        self.view?.render(props: self.makeProps())
                     }),
                     didTapLayersButton: CommandWith(action: { [weak self] type in
                        guard let self = self else { return }
                        self.layerType = type
                        self.isLayerViewExpanded.toggle()
                        self.view?.render(props: self.makeProps())
                     }),
                     isLayerViewExpanded: isLayerViewExpanded,
                     layerType: layerType,
                     didTapLocateButton: Command(action: { [weak self] in
                        guard let self = self else { return }
                        self.currentLocation = self.userLocation
                        self.view?.render(props: self.makeProps())
                     }),
                     didTapSearchButton: Command(action: { [weak self] in
                        guard let self = self else { return }
                        self.isSearchBarExpanded.toggle()
                        self.view?.render(props: self.makeProps())
                     }),
                     isSearchBarExpanded: isSearchBarExpanded,
                     didReceiveTextForSearch: CommandWith(action: { [weak self] text in
                        guard let self = self else { return }
                        self.searchText = text
                        self.isSearchBarExpanded.toggle()
                        self.view?.render(props: self.makeProps())
                     }),
                     didTapFilterButton: Command(action: { [weak self] in
                        guard let self = self else { return }
                        self.isFilterMenuExpanded.toggle()
                        self.view?.render(props: self.makeProps())
                     }),
                     didChooseCategoryFilter: CommandWith(action: { [weak self] type in
                        guard let self = self else { return }
                        self.categoryFilters = self.categoryFilters.symmetricDifference([type])
                        self.filterPlaces()
                     }),
                     categoryFilters: categoryFilters,
                     didChooseCategoryForFilter: CommandWith(action: { [weak self] type in
                        guard let self = self else { return }
                        self.categoryForFilters = self.categoryForFilters.symmetricDifference([type])
                        self.filterPlaces()
                     }),
                     categoryForFilters: categoryForFilters,
                     isFilterMenuExpanded: isFilterMenuExpanded,
                     userLocation: userLocation,
                     currentLocation: currentLocation,
                     visibleCoordinateBounds: visibleCoordinateBounds,
                     searchText: searchText)
    }
}
