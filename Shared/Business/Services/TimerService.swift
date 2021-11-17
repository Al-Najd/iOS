//
//  TimerService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//

import Combine
import Foundation

public protocol TimerServiceProtocol {
  func setTime(in seconds: TimeInterval)
  func start(timerTickHandler: Callback<String>?, finishHandler: VoidCallback?)
  func stop()
}

public final class TimerService: NSObject {
  public var didTimerEnd: Bool { remainingSeconds <= 0 }
  private var initialDate: Date = .now
  private var currentDate: Date = .now
  private var targetDate: Date = .now
  private var timer = Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()
  private var cancellables: Set<AnyCancellable> = []
  private var duration: Double {
    self.targetDate.secondsSince(self.initialDate)
  }
  
  private var remainingSeconds: Double {
    return targetDate.secondsSince(currentDate)
  }

  init(seconds: TimeInterval) {
    targetDate = .now.addingTimeInterval(seconds)
  }
}

// MARK: - Public API
public extension TimerService {
  func start(progressHandler: @escaping Callback<Double>) {
    timer.sink { [weak self] currentDate in
      guard let self = self else { return }
      self.currentDate = currentDate
      let progress = min(1, abs(1 - abs((self.remainingSeconds / self.duration))))
      progressHandler(progress)
      if self.didTimerEnd {
        self.timer.upstream.connect().cancel()
      }
    }.store(in: &cancellables)
  }
}
