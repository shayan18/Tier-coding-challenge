//
//  VehicleEndPointExt.swift
//  MobilityTests
//
//  Created by Shayan Ali on 03.07.22.
//

import ApiClient
import Foundation
import Microya

extension VehicleEndpoint {
  func mock(
    status: HttpStatus,
    mockedJson: MockedJson? = nil,
    headers: [String: String] = [:]
  ) -> MockedResponse {
    guard let mockedJson = mockedJson else {
      return mock(status: status, bodyJson: nil, headers: headers)
    }

    let bodyJson = try! String(data: Data(mockedJson: mockedJson), encoding: .utf8)
    return mock(status: status, bodyJson: bodyJson, headers: headers)
  }
}
