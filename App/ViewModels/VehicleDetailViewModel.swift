//
//  VehicleDetailViewModel.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import Foundation
import ApiClient

protocol VehicleDetailViewModelProtocol {
  var vehicle : Vehicle { get }
  var showData : ((Vehicle) ->())?{ get set }
}

final class VehicleDetailViewModel: VehicleDetailViewModelProtocol {
  var vehicle: Vehicle
  var showData: ((Vehicle) -> ())?
  var battery: String { "Battery Level: \(vehicle.batteryLevel)" }
  var maxSpeed: String { "Max Speed: \(vehicle.maxSpeed)" }
  var Location: String  { "Location: \(vehicle.lat) , \(vehicle.lng)" }
  var isHelmetAvailable: String { "Helmet available: \(vehicle.hasHelmetBox ? "YES" : "NO")" }

  init(vehicle : Vehicle) {
    self.vehicle = vehicle
  }

  func viewDidLoad() {
    self.showData?(self.vehicle)
  }
}
