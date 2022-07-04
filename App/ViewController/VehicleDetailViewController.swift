//
//  VehicleDetailViewController.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import UIKit

class VehicleDetailViewController: UIViewController {
  @IBOutlet private weak var batteryLabel: UILabel!
  @IBOutlet private weak var latLabel: UILabel!
  @IBOutlet private weak var maxSpeedLabel: UILabel!
  @IBOutlet private weak var typeLabel: UILabel!
  @IBOutlet private weak var helmetAvailablityLabel: UILabel!

  var viewModel : VehicleDetailViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindUI()
    self.viewModel.viewDidLoad()
  }

  private func bindUI() {
    self.viewModel.showData = { [weak self] vehicle in
      guard let self = self else { return }
      self.maxSpeedLabel.text = self.viewModel.maxSpeed
      self.batteryLabel.text = self.viewModel.battery
      self.typeLabel.text = vehicle.title
      self.latLabel.text = self.viewModel.Location
      self.helmetAvailablityLabel.text = self.viewModel.isHelmetAvailable
    }
  }
}
