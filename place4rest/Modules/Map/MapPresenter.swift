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
    private let placesRepository: PlacesRepository
    weak var view: MapView!

    // MARK: - Variables
    private var isLoading: Bool = true
    private var places: [Place] = []
    private var categoryFilters: Set<Category> = []
    private var categoryForFilters: Set<CategoryFor> = []
    private var layerType: Props.LayerType = .satellite
    private var isLayerViewExpanded: Bool = false
    private var isFilterMenuExpanded: Bool = false
    private var userLocation: Props.CameraLocation = .notSet
    private var currentLocation: Props.CameraLocation = .notSet
    private var visibleCoordinateBounds = MGLCoordinateBounds()

    // MARK: - Init
    init(placesService: PlacesService, placesRepository: PlacesRepository) {
        self.placesService = placesService
        self.placesRepository = placesRepository
    }

    // MARK: - MapView
    func viewWasLoaded() {
        placesService
            .getAllPlaces()
            .done { [weak self] in
                self?.placesRepository.save(places: $0)
            }.catch { error in
                debugPrint(error.localizedDescription)
            }.finally { [weak self] in
                guard let self = self else { return }
                self.places = self.placesRepository.fetchAllPlaces()
                self.isLoading = false
                self.view.render(props: self.makeProps())
        }
    }

    private func filterPlaces() {
        self.places = placesRepository.filterPlaces(categories: categoryFilters, for: categoryForFilters)
        view.render(props: self.makeProps())
    }
}

// MARK: - MGLMapViewDelegate
extension MapPresenter: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let annotationPoint: CGPoint = mapView.convert(annotation.coordinate, toPointTo: nil)
        let newAnnotationPoint = CGPoint(x: annotationPoint.x, y: annotationPoint.y - 145)
        let newPositionCoordinate: CLLocationCoordinate2D = mapView.convert(newAnnotationPoint, toCoordinateFrom: nil)
        mapView.setCenter(newPositionCoordinate, zoomLevel: mapView.zoomLevel, direction: mapView.direction, animated: true) {
            mapView.selectAnnotation(annotation, animated: false)
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
        return Props(isLoading: isLoading,
                     places: places,
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
                     visibleCoordinateBounds: visibleCoordinateBounds)
    }
}
