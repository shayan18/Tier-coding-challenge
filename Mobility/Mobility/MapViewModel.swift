//
//  MapViewModel.swift
//  Mobility
//
//  Created by Shayan Ali on 01.07.22.
//

import Foundation
import CoreLocation
import ApiClient

protocol MapViewModelProtocol {
  var refreshVehicles: ( () -> Void )? { get set }
}

class MapViewModel: MapViewModelProtocol {
  var refreshVehicles: (() -> Void)?
  var vehicles: [Vehicle] = []

  var showMessage: ((_ message: String) -> Void)?
  var updateState: ((_ status: Bool) -> Void)?
  private let vehicleService: VehicleService

  init(service: VehicleService) {
    vehicleService = service
  }

  func getVehicles() {
    updateState?(true)
    Task {
      do {
        vehicles = try await vehicleService.vehicles()
        refreshVehicles?()
        updateState?(false)
      } catch {
        print(error)
        showMessage?(error.localizedDescription)
        updateState?(false)
      }
    }
  }
}
