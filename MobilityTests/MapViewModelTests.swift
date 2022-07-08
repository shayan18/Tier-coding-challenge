//
//  MapViewModelTests.swift
//  MobilityTests
//
//  Created by Shayan Ali on 03.07.22.
//

import XCTest
import Microya
import ApiClient
@testable import Mobility
import CoreLocation

class MapViewModelTests: XCTestCase {
  func testClosestToLocation() throws {
    // Test Data
    let testClosestToLocation = CLLocation(latitude: 48.99673843020482, longitude: 8.352952950687778)
    let testLocations = [
      CLLocation(latitude: 52.517169, longitude: 13.394245),
      CLLocation(latitude: 52.522893, longitude: 13.378845),
      CLLocation(latitude: 52.536317, longitude: 13.473637),
      CLLocation(latitude: 52.515934, longitude: 13.373895)
    ]
    
    let viewModel = MapViewModel(service: .init(provider: TestContants.test))
    if let result = viewModel.closestLocation(locations: testLocations, closestToLocation: testClosestToLocation) {
      
      XCTAssertEqual(result.coordinate.latitude, 52.515934)
      XCTAssertEqual(result.coordinate.longitude, 13.373895)
    }
  }
}

