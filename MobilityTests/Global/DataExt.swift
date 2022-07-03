//
//  DataExt.swift
//  MobilityTests
//
//  Created by Shayan Ali on 03.07.22.
//

import Foundation

extension Data {
  init(
    mockedJson: MockedJson
  ) throws {
    guard
      let jsonFileUrl = Bundle(for: MapViewModelTests.self)
        .url(
          forResource: mockedJson.rawValue.firstUppercased,
          withExtension: "json"
        )
    else {
      // AnyLint.skipHere: SingleLineGuard
      fatalError("Reading mocked JSON data failed. File expected at: \(mockedJson.rawValue).json")
    }

    self = try Data(contentsOf: jsonFileUrl)
  }
}

extension StringProtocol {
  /// Returns a variation with the first character uppercased.
  public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
