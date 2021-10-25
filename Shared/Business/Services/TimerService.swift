//
//  TimerService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//

import Foundation

public protocol TimerServiceProtocol: Service {
  func setTime(in seconds: TimeInterval)
  func start(timerTickHandler: Callback<String>?, finishHandler: VoidCallback?)
  func stop()
}

public final class TimerService: NSObject {

  private var timer: Timer?
  private var currentDate: Date?
  private var timerTickHandler: Callback<Double>?
  private var finishHandler: VoidCallback?

  private var isTimerEnd: Bool { remaininSeconds <= .zero }
  private let calendar = Calendar.autoupdatingCurrent

  private var remaininSeconds: Double {
    guard let currentDate = currentDate else { return 0 }
    return Double(currentDate.timeIntervalSince(Date()))
  }

}

// MARK: - Public API
public extension TimerService {

  func setTime(in seconds: TimeInterval) {
    currentDate = Date().addingTimeInterval(seconds)
  }

  func start(timerTickHandler: Callback<Double>?, finishHandler: VoidCallback?) {
    self.timerTickHandler = timerTickHandler
    self.finishHandler = finishHandler

    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    timer?.fire()
  }

  func stop() {
    timer?.invalidate()
  }
}

// MARK: - Logic
private extension TimerService {

  @objc private func timerTick() {
    guard let timerTickHandler = timerTickHandler else { return }
    timerTickHandler(remaininSeconds)
    
    if isTimerEnd {
      endTime()
    }
  }

  private func endTime() {
    timer?.invalidate()
    finishHandler?()
  }
}
