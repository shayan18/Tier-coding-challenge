//
//  VehicleDetailViewModel.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import Foundation
import ApiClient

protocol VehicleDetailViewModelProtocol {
    var vehicle : Vehicle { get }
    var showData : ((Vehicle) ->())?{ get set }
    func viewDidLoad()
}

class VehicleDetailViewModel: VehicleDetailViewModelProtocol {
    var vehicle: Vehicle
    var showData: ((Vehicle) -> ())?

    init(data : Vehicle) {
        self.vehicle = data
    }

    func viewDidLoad() {
        self.showData?(self.vehicle)
    }
}
