//
//  MapViewModel.swift
//  Mobility
//
//  Created by Shayan Ali on 01.07.22.
//

import ApiClient
import CoreLocation
import Foundation
import Microya

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
    self.vehicleService = service
  }

  func getVehicles() {
    ongoingRequest?(true)
    Task {
      do {
        let apiKey = try! Secrets.load().apiKey
        vehicles = try await vehicleService.vehicles(apiKey: apiKey)
        refreshVehicles?()
        showMessage?(L10n.Vehicle.Request.success)
        ongoingRequest?(false)
      } catch {
        let apiError: ApiError<VehicleError> = error as! ApiError<VehicleError>
        showMessage?(AppError(error: apiError)?.title ?? L10n.Vehicle.Request.error)
        ongoingRequest?(false)
      }
    }
  }

  func closestVehicle(location: CLLocation?) -> CLLocation? {
    guard let userLocation = location else { return nil }
    return closestLocation(locations: vehicleLocations, closestToLocation:userLocation)
  }

  func configureUserLocation(location: CLLocationManager) {
    location.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      location.desiredAccuracy = kCLLocationAccuracyBest
      location.startUpdatingLocation()
    }
  }
}

extension MapViewModel {
  ///Find closestest location in all locations from given location
  func closestLocation(locations: [CLLocation], closestToLocation location: CLLocation) -> CLLocation? {
    if let closestLocation = locations.min(by: { location.distance(from: $0) < location.distance(from: $1) }) {
      return closestLocation
    } else {
      return nil
    }
  }
}
