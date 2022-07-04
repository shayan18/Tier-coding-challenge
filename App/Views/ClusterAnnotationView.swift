//
//  Clus.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import UIKit
import MapKit

final class ClusterAnnotationView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    didSet {
      guard let cluster = annotation as? MKClusterAnnotation else { return }
      displayPriority = .defaultHigh

      let clusterRect = CGRect(x: 0, y: 0, width: 40, height: 40)
      image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: clusterRect)
    }
  }
}
