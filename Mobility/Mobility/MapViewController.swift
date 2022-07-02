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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var mapView: MKMapView!
  let locationManager = CLLocationManager()
  let viewModel = MapViewModel(service: .init())
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.getVehicles()
    configureUserLocation()
    configureMapView()

    activityIndicator.startAnimating()
    viewModel.refreshVehicles = {
      self.activityIndicator.stopAnimating()
      let centerCoordinate = CLLocationCoordinate2D(latitude: self.viewModel.locations.first!.latitude, longitude: self.viewModel.locations.first!.longitude)
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let region = MKCoordinateRegion(center: centerCoordinate, span: span)
      self.mapView.setRegion(region, animated: false)

      var annotations = [MKPointAnnotation]()
      let locations = self.viewModel.vehicles.map{CLLocationCoordinate2D.init(latitude: $0.lat, longitude: $0.lng)}
      for location in locations {
        let annotation = MKPointAnnotation()
        annotation.title = "vehicle"
        annotation.coordinate = location
        annotations.append(annotation)
      }
      self.mapView.addAnnotations(annotations)
    }
  }

  func configureMapView() {
    mapView.showsUserLocation = true
    if let coor = mapView.userLocation.location?.coordinate{
        mapView.setCenter(coor, animated: true)
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
    
  }

}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {

}
