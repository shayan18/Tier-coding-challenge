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
