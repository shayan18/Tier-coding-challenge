//
//  Storyboarded.swift
//  AdventCalendar
//
//  Created by Shayan Ali on 05/03/2020.
//  Copyright © 2020 Shayan Ali. All rights reserved.
//

import UIKit

extension UIViewController {
  static func instantiateViewController<T: UIViewController>(with storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: .main)) -> T {
    let viewController: T = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    return viewController
  }
}

