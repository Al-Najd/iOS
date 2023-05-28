//
//  UIAlertAction+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 16/09/2022.
//

import Content
import UIKit

extension UIAlertAction {
    static let settingsAction = UIAlertAction(title: L10n.generalSettings, style: .destructive) { _ in
        let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
        if let url = settingsUrl {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

    static let cancelAction = UIAlertAction(title: L10n.generalCancel, style: .default, handler: nil)

    static let okAction = UIAlertAction(title: L10n.generalOk, style: .default, handler: nil)
}
