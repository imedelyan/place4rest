//
//  CLLocationCoordinate2D+Extension.swift
//  place4rest
//
//  Created by Igor Medelyan on 4/13/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    private func radians(from degrees: CLLocationDegrees) -> Double {
        return degrees * .pi / 180.0
    }

    private func degrees(from radians: Double) -> CLLocationDegrees {
        return radians * 180.0 / .pi
    }

    func adjust(by distance: CLLocationDistance, at bearing: CLLocationDegrees) -> CLLocationCoordinate2D {
        let distanceRadians = distance / 6_371.0   // 6,371 = Earth's radius in km
        let bearingRadians = radians(from: bearing)
        let fromLatRadians = radians(from: latitude)
        let fromLonRadians = radians(from: longitude)

        let toLatRadians = asin( sin(fromLatRadians) * cos(distanceRadians)
            + cos(fromLatRadians) * sin(distanceRadians) * cos(bearingRadians) )

        var toLonRadians = fromLonRadians + atan2(sin(bearingRadians)
            * sin(distanceRadians) * cos(fromLatRadians), cos(distanceRadians)
                - sin(fromLatRadians) * sin(toLatRadians))

        // adjust toLonRadians to be in the range -180 to +180...
        toLonRadians = fmod((toLonRadians + 3.0 * .pi), (2.0 * .pi)) - .pi

        let result = CLLocationCoordinate2D(latitude: degrees(from: toLatRadians), longitude: degrees(from: toLonRadians))

        return result
    }
}
