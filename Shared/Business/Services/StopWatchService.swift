//
//  StopWatchService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 26/10/2021.
//

import SwiftUI

public final class StopWatchService {
  public var onTimerTick: Callback<String>?
  public var onProgressTick: Callback<CGFloat>?
  public var limit: TimeInterval?
  
  private var start = Date()
  private var stopped : Date?
  private var resumed : Date?
  private var finished : Date?
  
  private var timer : Timer!
  
  private var timeElapsed = Double()
  private var timeStopped = Double()
  
  private var actualTimeSeconds: Int {
    Int(timeElapsed - timeStopped)
  }
  
  private var displayableSeconds : Int {
    actualTimeSeconds % 60
  }
  
  private var displayableMinutes : Int {
    (actualTimeSeconds / 60) % 60
  }
  
  private var displayableHours: Int {
    actualTimeSeconds / 3600
  }
  
  
  public func startTimer() {
    start = Date()
    timer = Timer(timeInterval: 1.0, target: self, selector: #selector(performActiveTimer), userInfo: nil, repeats: true)
    timer.tolerance = 0.2
    RunLoop.current.add(timer, forMode: .common)
  }
  
  public func reStartTimer() {
    
    resumed = Date()
    if let stop = stopped, let resume = resumed {
      timeStopped = timeStopped + (resume.timeIntervalSince1970 - stop.timeIntervalSince1970)
    }
    timer = Timer(timeInterval: 1.0, target: self, selector: #selector(performActiveTimer), userInfo: nil, repeats: true)
    timer.tolerance = 0.2
    RunLoop.current.add(timer, forMode: .common)
  }
  
  public func pause() {
    timer?.invalidate()
    stopped = Date()
  }
  
  @objc private func performActiveTimer() {
    timeElapsed = Date().timeIntervalSince1970 - start.timeIntervalSince1970
    onTimerTick?(
      StopWatchFormat.hms(
        hour: displayableHours,
        minute: displayableMinutes,
        second: displayableSeconds
      ).prepareForPresentation()
    )
    
    guard let limit = limit else { return }
    let timeDuration = start.advanced(by: limit).timeIntervalSince1970 - start.timeIntervalSince1970
    onProgressTick?(
      timeElapsed / timeDuration
    )
  }
  
  public func terminateTimerAndSave() {
    let now = Date()
    finished = now
    timeElapsed = now.timeIntervalSince1970 - start.timeIntervalSince1970
  }
}

enum StopWatchFormat {
  case hms(hour: Int, minute: Int, second: Int)
  
  func prepareForPresentation() -> String {
    switch self {
    case let .hms(hour, minute, second):
      
      switch (hour > 0, minute > 0, second > 0) {
      case (true, true, true):
        return String(format: "%02d : %02d : %02d", hour, minute, second)
      case (false, true, true):
        return String(format: "%02d : %02d", minute, second)
      case (false, false, true):
        return String(format: "00 : %02d", second)
      default:
        return ""
      }
    }
  }
}
