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

  /// Api key for Api Client
  static let apiKey: String = "9ef7d5b3-21c7-4a78-a92b-91efef42cabb"

  /// Default  map Span Coordinate
  static let defaultMapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

  /// Default duration for hiding toast messages after being presented.
  static let defaultToastDuration: Double = 3.0
}
