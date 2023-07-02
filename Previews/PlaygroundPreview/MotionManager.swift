//
//  MotionManager.swift
//  HomePreview
//
//  Created by Ahmed Ramy on 05/04/2023.
//

import CoreMotion

class MotionManager: ObservableObject {
    @Published var pitch = 0.0
    @Published var roll = 0.0
    @Published var rotation = 0.0

    var motion: CMMotionManager

    init() {
        motion = CMMotionManager()
        motion.deviceMotionUpdateInterval = 1 / 60
        motion.startDeviceMotionUpdates(to: .main) { motionData, error in
            guard error == nil else { return }
            guard let motionData else { return }
            self.pitch = motionData.attitude.pitch
            self.roll = motionData.attitude.roll
            self.rotation = motionData.rotationRate.x
        }
    }
}
