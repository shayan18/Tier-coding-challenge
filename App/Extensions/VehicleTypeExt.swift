//
//  VehicleTypeExt.swift
//  Mobility
//
//  Created by Shayan Ali on 08.07.22.
//

import ApiClient
import UIKit

extension VehicleType {
  var image: UIImage {
    switch self {
    case .escooter:
      return Asset.Images.scooter.image
    case .ebicycle:
      return Asset.Images.bike.image
    case .emoped:
      return Asset.Images.emob.image
    }
  }
}
