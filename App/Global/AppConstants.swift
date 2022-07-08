//
//  AppConstants.swift
//  Mobility
//
//  Created by Shayan Ali on 03.07.22.
//

import MapKit

enum AppConstants {
  /// The base URL of the API for the Production server.
  static let productionServerBaseUrl: URL = URL(string: "https://api.jsonstorage.net/v1")!

  /// Default  map Span Coordinate
  static let defaultMapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

  /// Default duration for hiding toast messages after being presented.
  static let defaultToastDuration: Double = 3.0
}
