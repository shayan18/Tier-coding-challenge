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
  func vehicles() async throws -> [Vehicle] {
    let apiProvider: ApiProvider<VehicleEndpoint> = .init(
      baseUrl: URL(string: "https://api.jsonstorage.net/v1")!
    )

    let result = await apiProvider.response(on: .vehicle(apiKey: "9ef7d5b3-21c7-4a78-a92b-91efef42cabb"), decodeBodyTo: ApiCollectionResponse<Vehicle>.self)

      switch result {
      case let .success(response):
        return response.data.compactMap { $0.attributes }

      case let .failure(error):
        print(error)
      }
    return []
  }
}


