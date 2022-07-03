//
//  VehicleService.swift
//  Mobility
//
//  Created by Shayan Ali on 01.07.22.
//

import ApiClient
import Foundation
import Microya

protocol VehicleProvidable {
  func vehicles() async throws -> [Vehicle]
}

struct VehicleService: VehicleProvidable {
  let provider: ApiProvider<VehicleEndpoint>

  func vehicles() async throws -> [Vehicle] {
    let result = await provider.response(on: .vehicle(apiKey: AppConstants.apiKey), decodeBodyTo: ApiCollectionResponse<Vehicle>.self)

      switch result {
      case let .success(response):
        return response.data.compactMap { $0.attributes }

      case let .failure(error):
        print(error)
      }
    return []
  }
}


