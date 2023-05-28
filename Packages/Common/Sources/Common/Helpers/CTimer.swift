//
//  CTimer.swift
//  CAFU
//
//  Created by Ahmed Ramy on 27/10/2022.
//

import Combine
import Foundation
import Loggers

// MARK: - Timeable

// sourcery: AutoMockable
public protocol Timeable: AnyObject {
    var onFire: (() -> Void)? { get set }
    var isRunning: Bool { get }

    func start()
    func stop()
}

// MARK: - CTimer

public class CTimer: Timeable {
    private let timeInterval: Double
    private lazy var timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer
        .publish(every: timeInterval, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()

    public private(set) var isRunning = false

    public init(timeInterval: Double) {
        self.timeInterval = timeInterval
        Log.info("Timer Instantiated", tags: [.timer])
    }

    deinit {
        stop()
        Log.info("Timer Deinitialized", tags: [.timer])
    }

    public var onFire: (() -> Void)?

    public func start() {
        timer.upstream.connect().cancel()
        timer = Timer.publish(every: timeInterval, on: .main, in: .common).autoconnect()
        timer.sink { [weak self] _ in
            guard let self = self else { return }
            self.onFire?()
            Log.info("Timer Fired!", tags: [.timer])
        }.store(in: &cancellables)
        Log.info("Timer Started", tags: [.timer])
        isRunning = true
    }

    public func stop() {
        timer.upstream.connect().cancel()
        Log.info("Timer Stopped", tags: [.timer])
        isRunning = false
    }
}
