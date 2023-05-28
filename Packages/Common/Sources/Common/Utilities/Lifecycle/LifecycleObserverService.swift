//
//  LifecycleObserverService.swift
//  CAFU
//
//  Created by Ahmed Ramy on 25/11/2022.
//

import Combine
import UIKit.UIApplication

// MARK: - LifecycleObserverServiceProtocol

public protocol LifecycleObserverServiceProtocol {
    var appWillGoToBackground: PassthroughSubject<Void, Never> { get }
    var appWillGoToForeground: PassthroughSubject<Void, Never> { get }
}

// MARK: - LifecycleObserverService

public final class LifecycleObserverService: LifecycleObserverServiceProtocol {
    public let appWillGoToBackground: PassthroughSubject<Void, Never> = .init()
    public let appWillGoToForeground: PassthroughSubject<Void, Never> = .init()

    public init() {
        setupApplicationLifecycleObservers()
    }

    deinit {
        appWillGoToForeground.send(completion: .finished)
        appWillGoToForeground.send(completion: .finished)
        NotificationCenter.default.removeObserver(self)
    }

    func setupApplicationLifecycleObservers() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: nil) { [weak self] _ in
                guard let self = self else { return }
                self.appWillGoToForeground.send()
            }

        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: nil) { [weak self] _ in
                guard let self = self else { return }
                self.appWillGoToBackground.send()
            }
    }
}
