//
//  DataFormatterDetailsForm.swift
//  Resources
//
//  Created by anass talii on Wed, 09 Feb 2022 16:47:59 GMT
//  ©2019 My Company All rights reserved

import UIKit
import QMobileUI

/// Generated details form for DataFormatter table.
@IBDesignable
class DataFormatterDetailsForm: DetailsFormBare {

    /// The record displayed in this form
    var record: DataFormatter {
        return super.record as! DataFormatter
    }

    // MARK: Events
    override func onLoad() {
        // Do any additional setup after loading the view.
    }

    override func onWillAppear(_ animated: Bool) {
        // Called when the view is about to made visible. Default does nothing
    }

    override func onDidAppear(_ animated: Bool) {
        // Called when the view has been fully transitioned onto the screen. Default does nothing
    }

    override func onWillDisappear(_ animated: Bool) {
        // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
    }

    override func onDidDisappear(_ animated: Bool) {
        // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
    }

    // MARK: Custom actions

}
