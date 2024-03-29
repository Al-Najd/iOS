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

// MARK: - SizeAdaptable

public protocol SizeAdaptable {
    associatedtype AdaptableType
    var maxVBreakpoint: DeviceHeight { get }
    var minVBreakpoint: DeviceHeight { get }

    var minHBreakPoint: DeviceWidth { get }
    var maxHBreakPoint: DeviceWidth { get }

    func getSelf() -> AdaptableType
}

// MARK: - SizeRangeAdaptable

public protocol SizeRangeAdaptable: SizeAdaptable {
    func adaptV(min: AdaptableType) -> AdaptableType
    func adaptV(max: AdaptableType) -> AdaptableType
    func adaptV(min: AdaptableType, max: AdaptableType) -> AdaptableType

    func adaptH(min: AdaptableType) -> AdaptableType
    func adaptH(max: AdaptableType) -> AdaptableType
    func adaptH(min: AdaptableType, max: AdaptableType) -> AdaptableType
}

// MARK: - SizeRatioAdaptable

public protocol SizeRatioAdaptable: SizeAdaptable {
    func adaptRatio() -> AdaptableType
}

// MARK: - Scale

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
        case .iPhone14ProMax,
             .iPhone13ProMax,
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

// MARK: - DeviceWidth

public enum DeviceWidth {
    case small
    case medium
    case large

    public init() {
        switch UIScreen.main.bounds.width {
        case ..<375:
            self = .small
        case ..<428:
            self = .medium
        default:
            self = .large
        }
    }

    public var width: CGFloat {
        switch self {
        case .small:
            return 375
        case .medium:
            return 428
        case .large:
            return UIScreen.main.bounds.width
        }
    }
}

// MARK: - DeviceHeight

public enum DeviceHeight {
    // iPads
    case iPadPro12
    case iPadPro11
    case iPadMini

    // iPhones
    case iPhone14ProMax
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
        case DeviceHeight.iPhone14ProMax.height:
            self = .iPhone14ProMax
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
//            assertionFailure("Height not found: \(size)")
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
        case .iPhone14ProMax:
            return 932
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
        case .iPhone14ProMax,
             .iPhone13Pro,
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
    var maxVBreakpoint: DeviceHeight {
        .iPadMini
    }

    var minVBreakpoint: DeviceHeight {
        .iPhoneSE
    }

    var maxHBreakPoint: DeviceWidth {
        .large
    }

    var minHBreakPoint: DeviceWidth {
        .small
    }

    func getSelf() -> Self {
        self
    }

    func adaptV(min: AdaptableType, max: AdaptableType) -> AdaptableType {
        let height = UIScreen.main.bounds.height
        let isTooSmall = height <= minVBreakpoint.height
        let isTooBig = height >= maxVBreakpoint.height
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
        let isTooSmall = height <= minVBreakpoint.height

        if isTooSmall {
            return min
        } else {
            return getSelf()
        }
    }

    func adaptV(max: AdaptableType) -> AdaptableType {
        let height = UIScreen.main.bounds.height
        let isTooBig = height >= maxVBreakpoint.height

        if isTooBig {
            return max
        } else {
            return getSelf()
        }
    }

    func adaptH(min: AdaptableType, max: AdaptableType) -> AdaptableType {
        let height = UIScreen.main.bounds.height
        let isTooSmall = height <= minHBreakPoint.width
        let isTooBig = height >= maxHBreakPoint.width
        if isTooBig {
            return max
        } else if isTooSmall {
            return min
        } else {
            return getSelf()
        }
    }

    func adaptH(min: AdaptableType) -> AdaptableType {
        let height = UIScreen.main.bounds.height
        let isTooSmall = height < minHBreakPoint.width

        if isTooSmall {
            return min
        } else {
            return getSelf()
        }
    }

    func adaptH(max: AdaptableType) -> AdaptableType {
        let height = UIScreen.main.bounds.width
        let isTooBig = height >= maxHBreakPoint.width

        if isTooBig {
            return max
        } else {
            return getSelf()
        }
    }
}

// MARK: - CGFloat + SizeRangeAdaptable

extension CGFloat: SizeRangeAdaptable {
    public func getSelf() -> CGFloat {
        self
    }
}

// MARK: - CGFloat + SizeRatioAdaptable

extension CGFloat: SizeRatioAdaptable {
    public func adaptRatio() -> CGFloat {
        self * DeviceHeight(size: UIScreen.main.bounds.height).multiplier
    }
}

// MARK: - Int + SizeRangeAdaptable

extension Int: SizeRangeAdaptable {
    public func getSelf() -> Int {
        self
    }
}

// MARK: - Double + SizeRangeAdaptable

extension Double: SizeRangeAdaptable {
    public func getSelf() -> Double {
        self
    }
}

// MARK: - Double + SizeRatioAdaptable

extension Double: SizeRatioAdaptable {
    public func adaptRatio() -> Double {
        self * DeviceHeight(size: UIScreen.main.bounds.height).multiplier
    }
}

// MARK: - HorizontalAlignment + SizeRangeAdaptable

extension HorizontalAlignment: SizeRangeAdaptable {
    public func getSelf() -> HorizontalAlignment {
        self
    }
}

// MARK: - TextAlignment + SizeRangeAdaptable

extension TextAlignment: SizeRangeAdaptable {
    public func getSelf() -> TextAlignment {
        self
    }
}

// MARK: - Alignment + SizeRangeAdaptable

extension Alignment: SizeRangeAdaptable {
    public func getSelf() -> Alignment {
        self
    }
}

public extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content)
        -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
