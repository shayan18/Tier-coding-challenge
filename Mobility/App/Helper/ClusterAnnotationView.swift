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

      let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
      image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
    }
  }
}


extension UIGraphicsImageRenderer {
  static func image(for annotations: [MKAnnotation], in rect: CGRect) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: rect.size)
    let countText = "\(annotations.count)"

    return renderer.image { _ in
      UIColor(red: 126 / 255.0, green: 211 / 255.0, blue: 33 / 255.0, alpha: 1.0).setFill()
      UIBezierPath(ovalIn: rect).fill()
      let piePath = UIBezierPath()

      piePath.addLine(to: CGPoint(x: 20, y: 20))
      piePath.close()
      piePath.fill()

      UIColor.white.setFill()
      UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()

      countText.drawForCluster(in: rect)
    }
  }
}

extension String {
  func drawForCluster(in rect: CGRect) {
    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
    let textSize = self.size(withAttributes: attributes)
    let textRect = CGRect(x: (rect.width / 2) - (textSize.width / 2),
                          y: (rect.height / 2) - (textSize.height / 2),
                          width: textSize.width,
                          height: textSize.height)

    self.draw(in: textRect, withAttributes: attributes)
  }
}
