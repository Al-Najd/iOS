//
//  PrayerCardView.swift
//
//
//  Created by Ahmed Ramy on 10/04/2023.
//

import SwiftUI
import Inject

// MARK: - PrayerCardView

public struct PrayerCardView: View {
    let title: String
    let reward: String
    let isDone: Bool
    let image: ImageAsset

    public init(prayer: Prayer) {
        title = prayer.title
        reward = prayer.reward.localized
        isDone = prayer.isDone
        image = prayer.image
    }

    public init(nafila: Nafila) {
        title = nafila.title
        reward = nafila.subtitle
        isDone = nafila.isDone
        image = nafila.image
    }

    public init(zekr: Zekr) {
        title = zekr.name
        reward = zekr.reward
        isDone = zekr.isDone
        image = Asset.Prayers.Faraaid.dhuhrImage
    }

    public var body: some View {
        VStack {
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .scaledFont(.pFootnote)
                    .padding(8)
                    .opacity(0.75)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.blueberryPrimary, .clear, .white.opacity(0.5)],
                                    startPoint: .leading,
                                    endPoint: .bottom)))
                    .padding()
                    .fillOnLeading()
                Spacer()

                ZStack(alignment: .top) {
                    VStack {
                        Text(reward)
                            .padding()
                            .foregroundColor(.white)
                            .scaledFont(.pFootnote, .regular)
                            .lineLimit(2)
                            .fillOnLeading()
                    }
                    .background(.ultraThinMaterial)
                    .opacity(0.75)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.white.opacity(0.5), .clear],
                                    startPoint: .top,
                                    endPoint: .bottom)))

                    if isDone {
                        Image(systemName: "checkmark.seal.fill")
                            .frame(width: 44, height: 44)
                            .foregroundColor(.success.darkMode)
                            .shadow(color: .success.darkMode.opacity(0.5), radius: 16, x: 0, y: 0)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [
                                        .white,
                                        .clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
                            .background(
                                HexagonShape()
                                    .stroke()
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [
                                                .white.opacity(0.5),
                                                .clear
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)))
                            .background(
                                HexagonShape()
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [
                                                .clear,
                                                .white.opacity(0.3),
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)))
                            .background(
                                HexagonShape()
                                    .fill()
                                    .foregroundColor(image.image.averageColor))
                            .offset(y: -22 - 4)
                    }
                }
            }
            .background(
                image
                    .swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill))
            .cornerRadius(16)
            .shadow(
                color: image.image.averageColor,
                radius: 25,
                x: 0,
                y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.white.opacity(0.25), image.image.averageColor, .clear],
                            startPoint: .top,
                            endPoint: .bottom)))
        }
    }
}

extension UIImage {
    var averageColor: Color {
        guard let inputImage = CIImage(image: self) else { return .clear }
        let extentVector = CIVector(
            x: inputImage.extent.origin.x,
            y: inputImage.extent.origin.y,
            z: inputImage.extent.size.width,
            w: inputImage.extent.size.height)

        guard
            let filter = CIFilter(
                name: "CIAreaAverage",
                parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return .clear }
        guard let outputImage = filter.outputImage else { return .clear }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: nil)

        return Color(UIColor(
            red: CGFloat(bitmap[0]) / 255,
            green: CGFloat(bitmap[1]) / 255,
            blue: CGFloat(bitmap[2]) / 255,
            alpha: CGFloat(bitmap[3]) / 255))
    }
}

// MARK: - HexagonShape

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.03337*width, y: 0.53897*height))
        path.addCurve(
            to: CGPoint(x: 0.02742*width, y: 0.43214*height),
            control1: CGPoint(x: 0.02839*width, y: 0.4835*height),
            control2: CGPoint(x: 0.02604*width, y: 0.45695*height))
        path.addCurve(
            to: CGPoint(x: 0.14168*width, y: 0.19309*height),
            control1: CGPoint(x: 0.03249*width, y: 0.34106*height),
            control2: CGPoint(x: 0.07342*width, y: 0.25542*height))
        path.addCurve(
            to: CGPoint(x: 0.22938*width, y: 0.12886*height),
            control1: CGPoint(x: 0.16028*width, y: 0.17611*height),
            control2: CGPoint(x: 0.18263*width, y: 0.1608*height))
        path.addCurve(
            to: CGPoint(x: 0.32124*width, y: 0.07043*height),
            control1: CGPoint(x: 0.27614*width, y: 0.09692*height),
            control2: CGPoint(x: 0.29852*width, y: 0.08167*height))
        path.addCurve(
            to: CGPoint(x: 0.59057*width, y: 0.04744*height),
            control1: CGPoint(x: 0.40462*width, y: 0.02917*height),
            control2: CGPoint(x: 0.50111*width, y: 0.02093*height))
        path.addCurve(
            to: CGPoint(x: 0.69143*width, y: 0.08943*height),
            control1: CGPoint(x: 0.61494*width, y: 0.05466*height),
            control2: CGPoint(x: 0.6397*width, y: 0.06589*height))
        path.addCurve(
            to: CGPoint(x: 0.78924*width, y: 0.13782*height),
            control1: CGPoint(x: 0.74316*width, y: 0.11296*height),
            control2: CGPoint(x: 0.7679*width, y: 0.12424*height))
        path.addCurve(
            to: CGPoint(x: 0.9443*width, y: 0.35388*height),
            control1: CGPoint(x: 0.86755*width, y: 0.18763*height),
            control2: CGPoint(x: 0.92311*width, y: 0.26504*height))
        path.addCurve(
            to: CGPoint(x: 0.95747*width, y: 0.46009*height),
            control1: CGPoint(x: 0.95008*width, y: 0.37808*height),
            control2: CGPoint(x: 0.95249*width, y: 0.40462*height))
        path.addCurve(
            to: CGPoint(x: 0.96341*width, y: 0.56692*height),
            control1: CGPoint(x: 0.96244*width, y: 0.51557*height),
            control2: CGPoint(x: 0.96479*width, y: 0.54211*height))
        path.addCurve(
            to: CGPoint(x: 0.84915*width, y: 0.80597*height),
            control1: CGPoint(x: 0.95834*width, y: 0.658*height),
            control2: CGPoint(x: 0.91741*width, y: 0.74365*height))
        path.addCurve(
            to: CGPoint(x: 0.76145*width, y: 0.8702*height),
            control1: CGPoint(x: 0.83056*width, y: 0.82295*height),
            control2: CGPoint(x: 0.80821*width, y: 0.83826*height))
        path.addCurve(
            to: CGPoint(x: 0.66959*width, y: 0.92864*height),
            control1: CGPoint(x: 0.71469*width, y: 0.90214*height),
            control2: CGPoint(x: 0.69231*width, y: 0.9174*height))
        path.addCurve(
            to: CGPoint(x: 0.40026*width, y: 0.95162*height),
            control1: CGPoint(x: 0.58621*width, y: 0.9699*height),
            control2: CGPoint(x: 0.48972*width, y: 0.97813*height))
        path.addCurve(
            to: CGPoint(x: 0.2994*width, y: 0.90964*height),
            control1: CGPoint(x: 0.37589*width, y: 0.9444*height),
            control2: CGPoint(x: 0.35113*width, y: 0.93317*height))
        path.addCurve(
            to: CGPoint(x: 0.2016*width, y: 0.86124*height),
            control1: CGPoint(x: 0.24767*width, y: 0.8861*height),
            control2: CGPoint(x: 0.22293*width, y: 0.87482*height))
        path.addCurve(
            to: CGPoint(x: 0.04653*width, y: 0.64518*height),
            control1: CGPoint(x: 0.12328*width, y: 0.81143*height),
            control2: CGPoint(x: 0.06772*width, y: 0.73402*height))
        path.addCurve(
            to: CGPoint(x: 0.03337*width, y: 0.53897*height),
            control1: CGPoint(x: 0.04075*width, y: 0.62098*height),
            control2: CGPoint(x: 0.03834*width, y: 0.59444*height))
        path.closeSubpath()
        return path
    }
}
