//
//  main.swift
//  Resources
//
//  Created by anass talii on Wed, 09 Feb 2022 16:47:59 GMT
//  ©2019 My Company All rights reserved

import Foundation
import QMobileUI

// Override main to inject 4D framework by settings QApplication as Application class
_ = UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(QApplication.self),
    NSStringFromClass(AppDelegate.self)
)
