//
//  MapItemAnnotationView.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import MapKit
import ApiClient

final class VehicleAnnotationView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    didSet {
      guard let mapItem = annotation as? Vehicle else { return }
      clusteringIdentifier = "Vehicle"
      image = mapItem.vehicleType.image
    }
  }
}

extension VehicleType {
  var image: UIImage {
    switch self {
    case .escooter:
      return #imageLiteral(resourceName: "scooter")
    case .ebicycle:
      return #imageLiteral(resourceName: "bike")
    case .emoped:
      return #imageLiteral(resourceName: "emob")
    }
  }
}

