//
//  NSObjectExt.swift
//  MobilityTests
//
//  Created by Shayan Ali on 03.07.22.
//

import Foundation

extension NSObject {
  static var className: String {
    return String(describing: self)
  }
}
