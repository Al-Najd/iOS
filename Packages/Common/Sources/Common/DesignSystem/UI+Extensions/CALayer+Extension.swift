//
//  CALayer+Extension.swift
//  CAFU
//
//  Created by Adithi Bolar on 19/10/2022.
//

import UIKit

public extension CALayer {
    internal var xVar: CGFloat {
        get {
            frame.minX
        }

        set {
            var frame = frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    internal var yVar: CGFloat {
        get {
            frame.minY
        }

        set {
            var frame = frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var midX: CGFloat {
        get {
            xVar + frame.width / 2.0
        }
        set {
            xVar += (newValue - self.midX)
        }
    }

    var midY: CGFloat {
        get {
            yVar + frame.height / 2.0
        }
        set {
            yVar += (newValue - self.midY)
        }
    }

    var left: CGFloat {
        get {
            frame.origin.x
        }

        set {
            var frame: CGRect = frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    var top: CGFloat {
        get {
            frame.origin.y
        }

        set {
            var frame: CGRect = frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var right: CGFloat {
        get {
            frame.origin.x + frame.size.width
        }
        set {
            var frame: CGRect = frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }

    var bottom: CGFloat {
        get {
            frame.origin.y + frame.size.height
        }

        set {
            var frame: CGRect = frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }

    var size: CGSize {
        get {
            frame.size
        }

        set {
            var rect: CGRect = frame
            rect.size = newValue
            frame = rect
        }
    }

    internal var width: CGFloat {
        get {
            frame.size.width
        }

        set {
            var frame = frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    internal var height: CGFloat {
        get {
            frame.size.height
        }

        set {
            var frame = frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
}
