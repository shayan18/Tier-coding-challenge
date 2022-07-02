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
  var places: [String] { get }
  var locations: [CLLocationCoordinate2D] { get }
  var refreshVehicles: ( () -> Void )? { get set }
}

class MapViewModel: MapViewModelProtocol {
  var refreshVehicles: (() -> Void)?
  var places: [String] { vehicles.compactMap{$0.vehicleType.rawValue} }

  var locations: [CLLocationCoordinate2D] { vehicles.compactMap{CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng)}}
  var vehicles: [Vehicle] = []
  private let vehicleService: VehicleService

  init(service: VehicleService) {
    vehicleService = service
  }

  func getVehicles() {
    Task {
      do {
        vehicles = try await vehicleService.vehicles()
        refreshVehicles?()
      }
      catch {
        print(error)
      }
    }
  }
}
