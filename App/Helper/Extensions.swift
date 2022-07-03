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
extension StoryboardInitializable where Self: Coordinator {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }

  static var storyboardName: UIStoryboard.Storyboard {
    return UIStoryboard.Storyboard.main
  }
  static func instantiateViewController() -> UIViewController {
    let storyboard = UIStoryboard.storyboard(storyboard: storyboardName)
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)

  }
}

