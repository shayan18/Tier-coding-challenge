//
//  AppEnv.swift
//  MobilityTests
//
//  Created by Shayan Ali on 03.07.22.
//

import Microya
import ApiClient

struct AppEnv {
  static let apiProvider: ApiProvider<VehicleEndpoint> = .init(
    baseUrl: AppConstants.productionServerBaseUrl
  )
}
