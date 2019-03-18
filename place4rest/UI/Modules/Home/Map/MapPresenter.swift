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

    // MARK: - Dependencies
    private let placesService: PlacesService
    weak var view: MapView!

    // MARK: - Variables
    lazy var props: MapViewController.Props = .init(mapItems: [],
                                                    layersButtonAction: .nop,
                                                    locateButtonAction: Command(action: showUserLocation),
                                                    searchButtonAction: .nop,
                                                    filterButtonAction: .nop,
                                                    filterType: .allPlaces,
                                                    layerType: .satellite,
                                                    userLocation: .notSet,
                                                    currentLocation: .notSet,
                                                    visibleCoordinateBounds: MGLCoordinateBounds())

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
                let mapItems = places.map {
                    MapViewController.Props.MapItem(place: $0, select: Command(action: {}))
                }
                self.props = .init(mapItems: mapItems,
                              layersButtonAction: self.props.layersButtonAction,
                              locateButtonAction: self.props.locateButtonAction,
                              searchButtonAction: self.props.searchButtonAction,
                              filterButtonAction: self.props.filterButtonAction,
                              filterType: self.props.filterType,
                              layerType: self.props.layerType,
                              userLocation: self.props.userLocation,
                              currentLocation: self.props.currentLocation,
                              visibleCoordinateBounds: self.props.visibleCoordinateBounds)
                self.view.render(props: self.props)
            }.catch { [weak self] in
                print($0.localizedDescription)
//                self?.view.display(errorMessage: $0.localizedDescription)
        }
    }

    private func showUserLocation() {
        props = .init(mapItems: props.mapItems,
                      layersButtonAction: props.layersButtonAction,
                      locateButtonAction: props.locateButtonAction,
                      searchButtonAction: props.searchButtonAction,
                      filterButtonAction: props.filterButtonAction,
                      filterType: props.filterType,
                      layerType: props.layerType,
                      userLocation: props.userLocation,
                      currentLocation: props.userLocation,
                      visibleCoordinateBounds: props.visibleCoordinateBounds)
        view?.render(props: props)
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
        let userLocation = MapViewController.Props.CameraLocation(coordinate: mapView.userLocation!.coordinate,
                                                                  zoomLevel: 5)
        props = .init(mapItems: props.mapItems,
                      layersButtonAction: props.layersButtonAction,
                      locateButtonAction: props.locateButtonAction,
                      searchButtonAction: props.searchButtonAction,
                      filterButtonAction: props.filterButtonAction,
                      filterType: props.filterType,
                      layerType: props.layerType,
                      userLocation: userLocation,
                      currentLocation: props.userLocation,
                      visibleCoordinateBounds: props.visibleCoordinateBounds)
        view?.render(props: props)
    }
}

// MARK: - Props Factory
extension MapPresenter {
    private func makeProps() {

    }
}
