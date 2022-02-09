//
//  Logger.swift
//  Resources
//
//  Created by anass talii on Wed, 09 Feb 2022 16:47:59 GMT
//  ©2019 My Company All rights reserved

import Foundation
import XCGLogger

let logger = XCGLogger.forClass(AppDelegate.self)

func logEvent(_ message: @autoclosure @escaping () -> Any?, _ importance: XCGLogger.Level, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    logger.log(importance, message(), functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo)
}
