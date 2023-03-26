//
//  ReportPlugin.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import OrdiLogging
import Pulse
import UIKit.UIApplication

// MARK: - ReportPlugin

struct ReportPlugin { }

// MARK: AppPlugin

extension ReportPlugin: AppPlugin {
    func setup() {
        setupPulse()
        setupSentry()
    }

    private func setupPulse() { }

    private func setupSentry() {
        SentryService.setup()
    }
}
