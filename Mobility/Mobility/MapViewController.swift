//
//  MapViewController.swift
//  Mobility
//
//  Created by Shayan Ali on 01.07.22.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var mapView: MKMapView!

  let locationManager = CLLocationManager()
  let viewModel = MapViewModel(service: .init())
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUserLocation()
    configureMapView()
    setupViewModelCallbacks()
    viewModel.getVehicles()
  }

  func configureMapView() {
    mapView.showsUserLocation = true
    if let coor = mapView.userLocation.location?.coordinate{
      mapView.setCenter(coor, animated: true)
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let region = MKCoordinateRegion(center: coor, span: span)
      self.mapView.setRegion(region, animated: false)
    }
  }
  func configureUserLocation() {
    self.locationManager.requestWhenInUseAuthorization()
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

    viewModel.refreshVehicles = {
      var annotations = [MKPointAnnotation]()
      for vehicle in self.viewModel.vehicles {
        let annotation = MKPointAnnotation()
        annotation.title = vehicle.vehicleType.rawValue
        annotation.coordinate = vehicle.location
        annotations.append(annotation)
      }
      self.mapView.addAnnotations(annotations)
    }
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation{
      return nil
    }
  
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Vehicle") as? MKMarkerAnnotationView
    if annotationView == nil {
      annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Vehicle")
    } else {
      annotationView?.annotation = annotation
    }
    return annotationView
  }
}
