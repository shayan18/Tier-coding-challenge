//
//  MapItem.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import MapKit
import ApiClient

final class MapItem: NSObject, MKAnnotation {

    let coordinate: CLLocationCoordinate2D
    let vehicleType: VehicleType
    var image: UIImage { return vehicleType.image }

  init(coordinate: CLLocationCoordinate2D, vehicleType: VehicleType) {
        self.coordinate = coordinate
        self.vehicleType = vehicleType
    }
}
