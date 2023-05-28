//
//  UIALertViewController+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 10/01/2023.
//

import Content
import UIKit

public extension UIViewController {
    // MARK: - SETTINGS ALERT

    func presentGeneralErrorAlert(title: String?, message: String) {
        let generalErrorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        generalErrorAlert.addAction(.okAction)
        DispatchQueue.main.async {
            self.present(generalErrorAlert, animated: true, completion: nil)
        }
    }

    func presentSettingsAlert(title: String?, message: String) {
        let settingsAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        settingsAlert.addAction(.cancelAction)
        settingsAlert.addAction(.settingsAction)
        DispatchQueue.main.async {
            self.present(settingsAlert, animated: true, completion: nil)
        }
    }

    func presentConfirmationAlert(title: String, message: String, completion: @escaping ((Bool) -> Void)) {
        let confirmationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: L10n.generalYes, style: .default, handler: { _ in
            completion(true)
        })
        let noAction = UIAlertAction(title: L10n.generalNo, style: .cancel, handler: { _ in
            completion(false)
        })
        confirmationAlert.addAction(yesAction)
        confirmationAlert.addAction(noAction)
        DispatchQueue.main.async {
            self.present(confirmationAlert, animated: true, completion: nil)
        }
    }
}
