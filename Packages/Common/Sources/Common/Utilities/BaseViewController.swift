//
//  BaseViewController.swift
//  CAFU
//
//  Created by Ahmed Ramy on 03/10/2022.
//

import Combine
import UIKit

// MARK: - BaseViewController

open class BaseViewController: UIViewController {
    public var cancellables: Set<AnyCancellable> = .init()

    override open func viewDidLoad() {
        super.viewDidLoad()
        generateAccessibilityIdentifiers()
    }
}

// MARK: Accessible

extension BaseViewController: Accessible { }
