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
import Toast

final class MapViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet private weak var mapView: MKMapView!
  @IBOutlet private weak var retryButton: UIButton!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

  private let locationManager = CLLocationManager()
  private let viewModel = MapViewModel(service: .init(provider: AppEnv.apiProvider))
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUserLocation()
    configureMapView()
    viewModel.getVehicles()
    viewModelOutputs()
  }
}

// MARK: View Configurations
private extension MapViewController {
  func configureMapView() {
    mapView.showsUserLocation = true
    mapView.register(
      VehicleAnnotationView.self,
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

  func SetupMapLocation(location: CLLocation?) {
    guard let closestVehicle = location else { return }
    mapView.setCenter(closestVehicle.coordinate, animated: true)
    let region = MKCoordinateRegion(center: closestVehicle.coordinate, span: AppConstants.defaultMapSpan)
    self.mapView.setRegion(region, animated: true)
  }

  private func showVehicleDetailView(vehicle: Vehicle) {
    let vehicleDetailVC: VehicleDetailViewController = VehicleDetailViewController.instantiateViewController()
    vehicleDetailVC.viewModel = .init(vehicle: vehicle)
    vehicleDetailVC.sheetPresentationController?.detents = [.medium()]
    vehicleDetailVC.sheetPresentationController?.prefersGrabberVisible = true
    present(vehicleDetailVC, animated: true, completion: nil)
  }
}

// MARK: Actions
private extension MapViewController {
  @IBAction func refreshPressed(_ sender: UIButton) {
    viewModel.getVehicles()
  }

  @IBAction func closestVehiclePressed(_ sender: UIButton) {
    SetupMapLocation(location: viewModel.closestVehicle(location: mapView.userLocation.location))
  }
  @IBAction func changeMapType(_ sender: UISegmentedControl) {
    mapView.mapType = sender.selectedSegmentIndex == 0 ? .standard : .mutedStandard
  }
}

// MARK: ViewModel Outputs
private extension MapViewController {
  func viewModelOutputs() {
    viewModel.ongoingRequest = { [weak self] status in
      DispatchQueue.main.async {
        if status {
          self?.activityIndicator.startAnimating()
        } else {
          self?.activityIndicator.stopAnimating()
        }
      }
    }

    viewModel.showMessage = { [weak self] message in
      DispatchQueue.main.async {
        self?.view.makeToast(message, duration: AppConstants.defaultToastDuration, position: .top)
      }
    }

    viewModel.refreshVehicles = { [weak self] in
      guard let self = self else { return }
      for vehicle in self.viewModel.vehicles {
        self.mapView.addAnnotation(vehicle)
      }

      DispatchQueue.main.async {
        self.retryButton.isHidden = true
        self.SetupMapLocation(location: self.viewModel.closestVehicle(location: self.mapView.userLocation.location))
      }
    }
  }
}

// MARK: MKMapView Delegates
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

    if let vehicle = view.annotation as? Vehicle {
      self.mapView.setCenter(vehicle.coordinate, animated: true)
      showVehicleDetailView(vehicle: vehicle)
    }
  }
}
