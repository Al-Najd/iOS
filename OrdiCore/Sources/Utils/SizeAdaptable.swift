//
//  SizeAdaptable.swift
//  Trojan
//
//  Created by Ahmed Ramy on 16/01/2022.
//

import SwiftUI

public func getScreenSize() -> CGRect {
  UIScreen.main.bounds
}

public protocol SizeAdaptable {
  associatedtype AdaptableType
  var maxBreakpoint: DeviceHeight { get }
  var minBreakpoint: DeviceHeight { get }
  func getSelf() -> AdaptableType
}

public protocol SizeRangeAdaptable: SizeAdaptable {
  func adaptV(min: AdaptableType) -> AdaptableType
  func adaptV(max: AdaptableType) -> AdaptableType
  func adaptV(min: AdaptableType, max: AdaptableType) -> AdaptableType
}

public protocol SizeRatioAdaptable: SizeAdaptable {
  func adaptRatio() -> AdaptableType
}

public enum Scale {
  case normal
  case tooSmall
  case tooBig
  
  public init(_ height: DeviceHeight) {
    switch height {
    case .iPadPro12,
        .iPadPro11,
        .iPadMini:
      self = .tooBig
    case .iPhone13ProMax,
        .iPhone13Pro,
        .iPhone13Mini,
        .iPhone11ProMax,
        .iPhone11Pro,
        .iPhone8Plus,
        .iPhone8:
      self = .normal
    case .iPhoneSE:
      self = .tooSmall
      
    }
  }
}

public enum DeviceHeight {
  // iPads
  case iPadPro12
  case iPadPro11
  case iPadMini
  
  // iPhones
  case iPhone13ProMax
  case iPhone13Pro
  case iPhone13Mini
  case iPhone11ProMax
  case iPhone11Pro
  case iPhoneSE
  case iPhone8Plus
  case iPhone8
  
  public init(size: CGFloat) {
    switch size {
    case DeviceHeight.iPadPro12.height:
      self = .iPadPro12
    case DeviceHeight.iPadPro11.height:
      self = .iPadPro11
    case DeviceHeight.iPadMini.height:
      self = .iPadMini
    case DeviceHeight.iPhone13ProMax.height:
      self = .iPhone13ProMax
    case DeviceHeight.iPhone13Pro.height:
      self = .iPhone13Pro
    case DeviceHeight.iPhone13Mini.height:
      self = .iPhone13Mini
    case DeviceHeight.iPhone11ProMax.height:
      self = .iPhone11ProMax
    case DeviceHeight.iPhoneSE.height:
      self = .iPhoneSE
    case DeviceHeight.iPhone8Plus.height:
      self = .iPhone8Plus
    case DeviceHeight.iPhone8.height:
      self = .iPhone8
    default:
      assertionFailure("Height not found: \(size)")
      self = .iPhone13Pro
    }
  }
  
  public var height: CGFloat {
    switch self {
    case .iPadPro12:
      return 1366
    case .iPadPro11:
      return 1194
    case .iPadMini:
      return 1133
    case .iPhone13ProMax:
      return 926
    case .iPhone13Pro:
      return 844
    case .iPhone13Mini:
      return 812
    case .iPhone11ProMax:
      return 896
    case .iPhoneSE:
      return 568
    case .iPhone8Plus:
      return 736
    case .iPhone8:
      return 667
    case .iPhone11Pro:
      return 812
    }
  }
  
  public var multiplier: CGFloat {
    switch self {
    case .iPadPro12:
      return 3
    case .iPadPro11:
      return 2.5
    case .iPadMini:
      return 2
    case .iPhone13ProMax:
      return 1.5
    case .iPhone11ProMax:
      return 1.3
    case .iPhone13Pro,
        .iPhone13Mini,
        .iPhone11Pro:
      return 1
    case .iPhone8Plus:
      return 0.9
    case .iPhone8:
      return 0.8
    case .iPhoneSE:
      return 0.6
    }
  }
}

public extension SizeRangeAdaptable {
  var maxBreakpoint: DeviceHeight {
    .iPadMini
  }
  
  var minBreakpoint: DeviceHeight {
    .iPhoneSE
  }
  
  func getSelf() -> Self {
    self
  }
  
  func adaptV(min: AdaptableType, max: AdaptableType) -> AdaptableType {
    let height = UIScreen.main.bounds.height
    let isTooSmall = height <= self.minBreakpoint.height
    let isTooBig = height >= self.maxBreakpoint.height
    if isTooBig {
      return max
    } else if isTooSmall {
      return min
    } else {
      return getSelf()
    }
  }
  
  func adaptV(min: AdaptableType) -> AdaptableType {
    let height = UIScreen.main.bounds.height
    let isTooSmall = height <= self.minBreakpoint.height
    
    if isTooSmall {
      return min
    } else {
      return getSelf()
    }
  }
  
  func adaptV(max: AdaptableType) -> AdaptableType {
    let height = UIScreen.main.bounds.height
    let isTooBig = height >= self.maxBreakpoint.height
    
    if isTooBig {
      return max
    } else {
      return getSelf()
    }
  }
}

extension CGFloat: SizeRangeAdaptable {
  public func getSelf() -> CGFloat {
    self
  }
}

extension CGFloat: SizeRatioAdaptable {
  public func adaptRatio() -> CGFloat {
    self * DeviceHeight(size: UIScreen.main.bounds.height).multiplier
  }
}

extension Int: SizeRangeAdaptable {
  public func getSelf() -> Int {
    self
  }
}

extension Double: SizeRangeAdaptable {
  public func getSelf() -> Double {
    self
  }
}

extension Double: SizeRatioAdaptable {
  public func adaptRatio() -> Double {
    self * DeviceHeight(size: UIScreen.main.bounds.height).multiplier
  }
}

extension HorizontalAlignment: SizeRangeAdaptable {
  public func getSelf() -> HorizontalAlignment {
    self
  }
}

extension TextAlignment: SizeRangeAdaptable {
  public func getSelf() -> TextAlignment {
    self
  }
}

extension Alignment: SizeRangeAdaptable {
  public func getSelf() -> Alignment {
    self
  }
}

public extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
