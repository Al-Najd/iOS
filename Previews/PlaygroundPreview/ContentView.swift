//
//  ContentView.swift
//  HomePreview
//
//  Created by Ahmed Ramy on 04/04/2023.
//

import SwiftUI
import DesignSystem
import Home

struct ContentView: View {
  @State var show = false
  @State var translation: CGSize = .zero
  @ObservedObject var manager = MotionManager()

  var drag: some Gesture {
    DragGesture()
      .onChanged { translation = .init(width: -$0.translation.width, height: $0.translation.height) }
      .onEnded { value in
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
          translation = .zero
        }
      }
  }

  var motion: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 50)
        .stroke(.linearGradient(
          colors: [.white.opacity(0.2), .white.opacity(0.5), .clear], startPoint: .topLeading,
          endPoint: UnitPoint(x: abs(manager.roll) * 5 + 1, y: abs(manager.roll) * 5 + 1))
        )

      LinearGradient(
        colors: [.clear, .white.opacity(0.5), .clear],
        startPoint: .topLeading,
        endPoint: UnitPoint(x: abs(manager.roll) * 10 + 1, y: abs(manager.roll) * 10 + 1)
      )
      .cornerRadius(50)

      LinearGradient(
        colors: [Color.primary.default],
        startPoint: .topLeading,
        endPoint: UnitPoint(x: abs(manager.roll) * 10 + 1, y: abs(manager.roll) * 10 + 1)
      )
      .blendMode(.softLight)
      .cornerRadius(50)
    }
  }

  var body: some View {
    ZStack {
      HomeView(store: .init(initialState: .init(), reducer: Home()))
        .cornerRadius(50)
        .overlay(motion)
        .scaleEffect(x: show ? 0.95 : 1, y: show ? 0.9 : 1)
        .animation(.spring(), value: show)

      Rectangle()
        .fill(.ultraThinMaterial)
        .overlay(Rectangle().fill(.black.opacity(0.5).blendMode(.overlay)))
        .mask(canvas)
        .shadow(color: .white.opacity(0.2), radius: 0, x: -1, y: -1)
        .shadow(color: .black.opacity(0.2), radius: 0, x: 1, y: 1)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: 10)
        .overlay(icons)
        .background(
          circle.frame(width: 208)
            .overlay(circle.frame(width: 60))
            .overlay(circle.frame(width: 80))
            .offset(x: -60, y: 60)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0.8, anchor: .bottomLeading)
        )
        .offset(y: -29)
        .onTapGesture {
          withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
            show.toggle()
          }
        }

    }
    .background(.black)
    .ignoresSafeArea()
    .preferredColorScheme(.dark)
  }

  var circle: some View {
    Circle().stroke(lineWidth: 1).fill(.linearGradient(colors: [.white.opacity(0.5), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
  }

  var icons: some View {
    ZStack {
      Image(systemName: "plus")
        .font(.system(size: 30))
        .rotationEffect(.degrees(show ? 45 : 0))
        .offset(x: 24, y: -28)

      Group {
        Image(systemName: "bubble.left.fill")
          .font(.system(size: 30))
          .offset(x: 24, y: -129)
        Image(systemName: "moon.fill")
          .font(.system(size: 30))
          .offset(x: 124, y: -29)

        Image(systemName: "quote.opening")
          .font(.system(size: 30))
          .offset(x: 108, y: -114)
      }
      .opacity(show ? 1 : 0)
      .blur(radius: show ? 0 : 10)
      .scaleEffect(show ? 1 : 0.5)
    }
    .foregroundColor(.white)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
  }

  var canvas: some View {
    Canvas { context, size in
      context.addFilter(.alphaThreshold(min: 0.8))
      context.addFilter(.blur(radius: 10))
      context.drawLayer { ctx in
        for index in 1...5 {
          if let symbol = context.resolveSymbol(id: index) {
            ctx.draw(symbol, at: .init(x: size.width - 44, y: size.height - 44))
          }
        }
      }
    } symbols: {
      Circle()
        .frame(width: 76)
        .tag(1)

      Circle()
        .frame(width: 76)
        .tag(2)
        .offset(x: show ? 100 : 0)

      Circle()
        .frame(width: 76)
        .tag(3)
        .offset(x: show ? 84 : 0, y: show ? -84 : 0)

      Circle()
        .frame(width: 76)
        .tag(4)
        .offset(y: show ? -100 : 0)

      Circle()
        .frame(width: 76)
        .tag(5)
        .offset(translation)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public func getScreenSize() -> CGRect {
  UIScreen.main.bounds
}

func getSafeArea() -> UIEdgeInsets {
  (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
    .windows.first?.safeAreaInsets ?? .zero
  }
