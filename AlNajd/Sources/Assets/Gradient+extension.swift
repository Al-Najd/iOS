//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 09/10/2022.
//

import SwiftUI

public extension LinearGradient {
	static let homeLowCharge: LinearGradient = .init(
		colors: [
			Color("Gradients/Home/LowCharge/ProgressStart"),
			Color("Gradients/Home/LowCharge/ProgressEnd")
		],
		startPoint: .top,
		endPoint: .bottom)

	static let homeMidCharge: LinearGradient = .init(
		colors: [
			Color("Gradients/Home/MidCharge/ProgressStart"),
			Color("Gradients/Home/MidCharge/ProgressEnd")
		],
		startPoint: .top,
		endPoint: .bottom)

	static let homeHighCharge: LinearGradient = .init(
		colors: [
			Color("Gradients/Home/HighCharge/ProgressStart"),
			Color("Gradients/Home/HighCharge/ProgressEnd")
		],
		startPoint: .leading,
		endPoint: .trailing)
}
