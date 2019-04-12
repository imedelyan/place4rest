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
    private var mapItems: [Props.MapItem] = []
    private var filterType: Props.FilterType = .allPlaces
    private var layerType: Props.LayerType = .satellite
    private var isLayerViewExpanded: Bool = false
    private var isSearchBarExpanded: Bool = false
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
        placesService
            .getAllPlaces()
            .done { [weak self] places in
                self?.mapItems = places.map {
                    Props.MapItem(place: $0, select: Command(action: {}))
                }
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
        let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, acrossDistance: 4500, pitch: 15, heading: 180)
        mapView.fly(to: camera, withDuration: 4, peakAltitude: 3000, completionHandler: nil)
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        guard let location = mapView.userLocation, location.coordinate.latitude > -180 else { return }
        userLocation = Props.CameraLocation(coordinate: location.coordinate, zoomLevel: 5)
        currentLocation = userLocation
        view?.render(props: makeProps())
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        visibleCoordinateBounds = mapView.visibleCoordinateBounds
    }

    // This delegate method is where you tell the map to load a view for a specific annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {

        guard let castAnnotation = annotation as? PlaceAnnotation, !castAnnotation.willUseImage else { return nil }

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

    // This delegate method is where you tell the map to load an image for a specific annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {

        guard let placeAnnotation = annotation as? PlaceAnnotation, placeAnnotation.willUseImage else { return nil }

        guard let category = placeAnnotation.place.categories.first else { return nil }
        switch category {
        case 4: // wildnights
            // For better performance, always try to reuse existing annotations.
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "tree")
            // If there is no reusable annotation image available, initialize a new one.
            if annotationImage == nil {
                annotationImage = MGLAnnotationImage(image: R.image.tree()!, reuseIdentifier: "tree")
            }
            return annotationImage
        case 6: // castles
            // For better performance, always try to reuse existing annotations.
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "castle")
            // If there is no reusable annotation image available, initialize a new one.
            if annotationImage == nil {
                annotationImage = MGLAnnotationImage(image: R.image.castle()!, reuseIdentifier: "castle")
            }
            return annotationImage
        case 5: // springs
            // For better performance, always try to reuse existing annotations.
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "fontain")
            // If there is no reusable annotation image available, initialize a new one.
            if annotationImage == nil {
                annotationImage = MGLAnnotationImage(image: R.image.fontain()!, reuseIdentifier: "fontain")
            }
            return annotationImage
        case 76: // nightparking
            // For better performance, always try to reuse existing annotations.
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "car")
            // If there is no reusable annotation image available, initialize a new one.
            if annotationImage == nil {
                annotationImage = MGLAnnotationImage(image: R.image.car()!, reuseIdentifier: "car")
            }
            return annotationImage
        case 72: // camping
            // For better performance, always try to reuse existing annotations.
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "car")
            // If there is no reusable annotation image available, initialize a new one.
            if annotationImage == nil {
                annotationImage = MGLAnnotationImage(image: R.image.car()!, reuseIdentifier: "car")
            }
            return annotationImage
        default:
            return nil
        }
    }

    //    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    //        // Only show callouts for `Hello world!` annotation.
    //        return annotation.responds(to: #selector(getter: MGLAnnotation.title)) && annotation.title! == "Hello world!"
    //    }
    //
    //    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
    //        // Instantiate and return our custom callout view.
    //        return CustomCalloutView(representedObject: annotation)
    //    }
    //
    //    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
    //        // Optionally handle taps on the callout.
    //        print("Tapped the callout for: \(annotation)")
    //
    //        // Hide the callout.
    //        mapView.deselectAnnotation(annotation, animated: true)
    //    }
}

// MARK: - Props Factory
extension MapPresenter {
    private func makeProps() -> Props {
        return Props(mapItems: mapItems,
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
                     didTapFilterButton: CommandWith(action: { [weak self] type in
                        guard let self = self else { return }
                        self.filterType = type
                        self.view?.render(props: self.makeProps())
                     }),
                     filterType: filterType,
                     userLocation: userLocation,
                     currentLocation: currentLocation,
                     visibleCoordinateBounds: visibleCoordinateBounds,
                     searchText: searchText)
    }
}
