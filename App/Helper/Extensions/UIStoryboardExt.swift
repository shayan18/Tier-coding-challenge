//
//  Extensions.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import UIKit
/**
 - Storyboard : enum for saving storyboard name
 - storyboard : initialise storyboard
 */
extension UIStoryboard {

  enum Storyboard: String {
    case main
    var filename: String {
      return rawValue.capitalized
    }
  }

  class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.filename, bundle: bundle)
  }
}


