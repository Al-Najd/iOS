//
//  Double+Extension.swift
//  CAFU
//
//  Created by Adithi Bolar on 07/10/2022.
//

import Foundation

extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    var intValue: Int {
        Int(self)
    }
}
