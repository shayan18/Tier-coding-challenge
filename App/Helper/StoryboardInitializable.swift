//
//  StoryboardInitializible.swift
//  Mobility
//
//  Created by Shayan Ali on 02.07.22.
//

import Foundation
import UIKit

/**
 For initializeing story board and instantiaing ViewController .

 - storyboardIdentifier : Should be same as class name
 - storyboardName : storyboard enum
 - instantiateViewController : for instantiating viewcontroller
 */
protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
    static var storyboardName: UIStoryboard.Storyboard { get }
    static func instantiateViewController() -> UIViewController
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
