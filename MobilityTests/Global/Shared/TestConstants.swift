//
//  TestConstants.swift
//  MobilityTests
//
//  Created by Shayan Ali on 03.07.22.
//

import Foundation
import ApiClient
import Microya
import CombineSchedulers

enum TestContants {
  /// The delay to put on API requests returning a result.
  static let requestDelay: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(300)

  /// The test scheduler to control time in tests.
  static let scheduler: TestScheduler = DispatchQueue.test

  /// Test Provider
  static var test: ApiProvider<VehicleEndpoint> {
    ApiProvider<VehicleEndpoint>(
      baseUrl: URL(string: "https://api.jsonstorage.net/v1")!,
      mockingBehavior: .init(
        delay: DispatchQueue.SchedulerTimeType.Stride(10.0),
        scheduler: TestContants.scheduler.eraseToAnyScheduler(),
        mockedResponseProvider: { endpoint in
          switch endpoint {
          case .vehicle:
            return endpoint.mock(status: .ok, mockedJson: .vehicles)
          }
        }
      )
    )
  }
}
