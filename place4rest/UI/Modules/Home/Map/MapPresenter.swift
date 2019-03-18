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
//        view.setLoading(hidden: false)
        placesService
            .getAllPlaces()
            .ensure { [weak self] in
//                self?.view.setLoading(hidden: true)
            }.done { [weak self] places in
                guard let self = self else { return }
                self.mapItems = places.map {
                    Props.MapItem(place: $0, select: Command(action: {}))
                }
                self.view.render(props: self.makeProps())
            }.catch { [weak self] in
                print($0.localizedDescription)
//                self?.view.display(errorMessage: $0.localizedDescription)
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
}

// MARK: - Props Factory
extension MapPresenter {
    private func makeProps() -> Props {
        return Props(mapItems: mapItems,
                     layersButtonAction: CommandWith(action: { [weak self] type in
                        guard let self = self else { return }
                        self.layerType = type
                        self.view?.render(props: self.makeProps())
                     }),
                     locateButtonAction: Command(action: { [weak self] in
                        guard let self = self else { return }
                        self.currentLocation = self.userLocation
                        self.view?.render(props: self.makeProps())
                     }),
                     searchButtonAction: CommandWith(action: { [weak self] text in
                        guard let self = self else { return }
                        self.searchText = text
                        self.view?.render(props: self.makeProps())
                     }),
                     filterButtonAction: CommandWith(action: { [weak self] type in
                        guard let self = self else { return }
                        self.filterType = type
                        self.view?.render(props: self.makeProps())
                     }),
                     filterType: filterType,
                     layerType: layerType,
                     userLocation: userLocation,
                     currentLocation: currentLocation,
                     visibleCoordinateBounds: visibleCoordinateBounds,
                     searchText: searchText)
    }
}
