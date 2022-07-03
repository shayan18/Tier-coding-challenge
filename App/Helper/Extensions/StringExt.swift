//
//  StringExt.swift
//  Mobility
//
//  Created by Shayan Ali on 03.07.22.
//

import Foundation
import UIKit

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
