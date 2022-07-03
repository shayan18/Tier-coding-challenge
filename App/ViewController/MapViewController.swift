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
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var mapView: MKMapView!

  private let locationManager = CLLocationManager()
  private let viewModel = MapViewModel(service: .init(provider: AppEnv.apiProvider))
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUserLocation()
    configureMapView()
    setupViewModelCallbacks()
    viewModel.getVehicles()
  }
  @IBAction func refreshPressed(_ sender: UIButton) {
    viewModel.getVehicles()

  }
}

// MARK: View Configurations
private extension MapViewController {
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

  func SetupMapLocation(location: CLLocation?) {
    guard let closestVehicle = location else { return }
    mapView.setCenter(closestVehicle.coordinate, animated: true)
    let region = MKCoordinateRegion(center: closestVehicle.coordinate, span: AppConstants.defaultMapSpan)
    self.mapView.setRegion(region, animated: true)
  }
}

// MARK: Actions
private extension MapViewController {
  @IBAction func closestVehiclePressed(_ sender: UIButton) {
    SetupMapLocation(location: viewModel.closestVehicle(location: mapView.userLocation.location))
  }
  @IBAction func changeMapType(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      mapView.mapType = .standard
    } else {
      mapView.mapType = .satellite
    }
  }
}

// MARK: ViewModel Outputs
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
      DispatchQueue.main.async {
        self?.view.makeToast(message, duration: AppConstants.defaultToastDuration, position: .bottom)
      }
    }

    viewModel.refreshVehicles = { [weak self] in
      guard let self = self else { return }
      for vehicle in self.viewModel.vehicles {
        self.mapView.addAnnotation(MapItem(coordinate: vehicle.coordinate, vehicleType: vehicle.vehicleType))
      }

      DispatchQueue.main.async {
        self.SetupMapLocation(location: self.viewModel.closestVehicle(location: self.mapView.userLocation.location))
      }
    }
  }
}

// MARK: MKMapView Delegates
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "vehicleDetail") as! VehicleDetailViewController
    vc.sheetPresentationController?.detents = [.medium()]

    vc.sheetPresentationController?.prefersGrabberVisible = true
    //  self.present(vc, animated: true, completion: nil)
  }
}
