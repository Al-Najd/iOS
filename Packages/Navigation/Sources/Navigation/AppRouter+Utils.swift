//
//  File.swift
//
//
//  Created by Ahmed Ramy on 31/03/2023.
//

import UIKit

public extension AppRouter {
    func makePhoneCall(_ phone: String) {
        let url: NSURL = URL(string: "tel://\(phone)")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
