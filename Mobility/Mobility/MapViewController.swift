//
//  MapViewController.swift
//  Mobility
//
//  Created by Shayan Ali on 01.07.22.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

  @IBOutlet private weak var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction private func changeMapType(_ sender: UISegmentedControl) {
    
  }

}

