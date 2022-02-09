//
//  MainNavigation.swift
//  Resources
//
//  Created by anass talii on Wed, 09 Feb 2022 16:47:59 GMT
//  ©2019 My Company All rights reserved

import Foundation
import UIKit
import QMobileUI

/// The main navigation controller of your application. Which use tab bar as navigation mode.
/// see https://developer.apple.com/documentation/uikit/uitabbarcontroller
class MainNavigation: UITabBarController, MainNavigationForm {

    override open func viewDidLoad() {
        super.viewDidLoad()
        customizeMoreView()
    }

}
