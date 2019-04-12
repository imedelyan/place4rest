//
//  PlaceAnnotation.swift
//  place4rest
//
//  Created by Igor Medelian on 4/12/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Mapbox

class PlaceAnnotation: MGLPointAnnotation {
    var willUseImage: Bool = false
    var place: Place = Place()
}
