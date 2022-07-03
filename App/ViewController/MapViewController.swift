//
//  MapViewController.swift
//  Mobility
//
//  Created by Shayan Ali on 01.07.22.
//

import UIKit
import MapKit
import CoreLocation
import ApiClient

final class MapViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var mapView: MKMapView!

  private let locationManager = CLLocationManager()
  private let viewModel = MapViewModel(service: .init())
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUserLocation()
    configureMapView()
    setupViewModelCallbacks()
    viewModel.getVehicles()
  }

  func ShowNearestVehicle(location: CLLocation?) {
    guard let closestVehicle = location else { return }
    mapView.setCenter(closestVehicle.coordinate, animated: true)
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: closestVehicle.coordinate, span: span)
    self.mapView.setRegion(region, animated: true)
  }

  func configureMapView() {
    mapView.showsUserLocation = true
    mapView.register(
      MapItemAnnotationView.self,
      forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    mapView.register(
      ClusterAnnotationView.self,
      forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
  }

  func configureUserLocation() {
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
  }

  @IBAction private func changeMapType(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      mapView.mapType = .standard
    } else {
      mapView.mapType = .satellite
    }
  }
}

private extension MapViewController {
  func setupViewModelCallbacks() {
    viewModel.updateState = { [weak self] status in
      if status {
        self?.activityIndicator.startAnimating()
      } else {
        DispatchQueue.main.async {
          self?.activityIndicator.stopAnimating()
        }
      }
    }

    viewModel.showMessage = { [weak self] message in
      print(message)
    }

    viewModel.refreshVehicles = { [weak self] in
      guard let self = self else { return }
      for vehicle in self.viewModel.vehicles {
        self.mapView.addAnnotation(MapItem(coordinate: vehicle.coordinate, vehicleType: vehicle.vehicleType))
      }

      DispatchQueue.main.async {
        self.ShowNearestVehicle(location: self.viewModel.closestVehicle(location: self.mapView.userLocation.location))
      }
    }
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "vehicleDetail") as! VehicleDetailViewController
    vc.sheetPresentationController?.detents = [.medium()]

    vc.sheetPresentationController?.prefersGrabberVisible = true
    //  self.present(vc, animated: true, completion: nil)
  }
}
