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
  var vehicleLocations: [CLLocation] { get }
}

class MapViewModel: MapViewModelProtocol {
  var vehicleLocations: [CLLocation] { vehicles.map { CLLocation(latitude: $0.lat, longitude: $0.lng) } }
  var refreshVehicles: (() -> Void)?
  var vehicles: [Vehicle] = []

  var showMessage: ((_ message: String) -> Void)?
  var ongoingRequest: ((_ status: Bool) -> Void)?
  private let vehicleService: VehicleService

  init(service: VehicleService) {
    vehicleService = service
  }

  func closestVehicle(location: CLLocation?) -> CLLocation? {
    guard let userLocation = location else { return nil }
    return closestLocation(locations: vehicleLocations, closestToLocation:userLocation)
  }

  func getVehicles() {
    ongoingRequest?(true)
    Task {
      do {
        vehicles = try await vehicleService.vehicles()
        refreshVehicles?()
        showMessage?("Vehicles fetched successfully")
        ongoingRequest?(false)
      } catch {
        showMessage?(error.localizedDescription)
        ongoingRequest?(false)
      }
    }
  }
}

extension MapViewModel {
  func closestLocation(locations: [CLLocation], closestToLocation location: CLLocation) -> CLLocation? {
    if let closestLocation = locations.min(by: { location.distance(from: $0) < location.distance(from: $1) }) {
      return closestLocation
    } else {
      return nil
    }
  }
}
