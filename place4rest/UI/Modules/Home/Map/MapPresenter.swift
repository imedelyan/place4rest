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
                guard let self = self else { return }
                self.mapItems = places.map {
                    Props.MapItem(place: $0, select: Command(action: {}))
                }
                self.view.render(props: self.makeProps())
            }.catch {
                print($0.localizedDescription)
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
