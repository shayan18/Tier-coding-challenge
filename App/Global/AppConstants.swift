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

  /// Api key for network requests
  static let apiKey: String = "9ef7d5b3-21c7-4a78-a92b-91efef42cabb"

  /// Default  map Span Coordinate
  static let defaultMapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

  /// Default duration for hiding toast messages after being presented.
  static let defaultToastDuration: Double = 3.0

  /// Default success response message for requests
  static let defaultSuccessMessage: String = "Vehicles fetched successfully"

  /// Default failure response message for requests
  static let defaultFailureMessage: String = "Something went wrong, please check your internet connection"
}
