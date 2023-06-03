//
//  DebugView.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/10/2022.
//

import Combine
import Factory
import PulseUI
import SwiftUI

// MARK: - DebugView

public struct DebugView: View {
    @ObservedObject var debugConfig: DebugConfig = Container.shared.debugConfigs()

    @State var showPulse = false

    private var cancellables = Set<AnyCancellable>()
    public init() { }

    public var body: some View {
        VStack {
            Text("CAFU Debug View")
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding()

            List {
                Section {
                    Button("Pulse") {
                        showPulse = true
                    }.foregroundColor(.primary)
                } header: {
                    Text("DEBUGGERS")
                } footer: {
                    Text("Can be used to debug Network Responses, Latencies or Cache values & edit them")
                }

                Section {
                    // MARK: - Bool Values
                    ForEach($debugConfig.boolConfigs) { $config in
                        VStack {
                            Toggle(isOn: $config.value) {
                                Text(config.title)
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }

                            if let description = config.description {
                                Text(description)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                } header: {
                    Text("CONFIGURATIONS")
                } footer: {
                    Text("Configure the Dev Experience")
                }

                Section {
                    // MARK: - Bool Values
                    ForEach($debugConfig.actionConfigs) { $config in
                        VStack {
                            Button(action: config.onExecute) {
                                Text(config.title)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            if let description = config.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }.padding(.vertical, 4)
                    }
                } header: {
                    Text("ACTIONS")
                } footer: {
                    Text("Execute some code for debugging reasons (may break the app)")
                }
            }

            Spacer()

            Text("Happy Debugging 👾")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .sheet(isPresented: $showPulse, content: {
            NavigationView {
                ConsoleView()
            }
        })
    }
}

// MARK: - DebugView_Previews

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}

// MARK: - DebugBoolValue

public class DebugBoolValue: Identifiable, ObservableObject {
    public var id: String { title }
    public let title: String
    public let description: String?
    @Published public var value = false

    public init(title: String, description: String? = nil, value: Bool = false) {
        self.value = value
        self.title = title
        self.description = description
    }
}

// MARK: - DebugActionValue

public struct DebugActionValue: Identifiable {
    public var id: String { title }
    public let title: String
    public let description: String?
    public var onExecute: () -> Void

    public init(title: String, description: String? = nil, onExecute: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.onExecute = onExecute
    }
}

// MARK: - DebugConfig

public class DebugConfig: ObservableObject {
    @Published public var boolConfigs: [DebugBoolValue] = []
    @Published public var actionConfigs: [DebugActionValue] = []
}

public extension Container {
    var debugConfigs: Factory<DebugConfig> { self { DebugConfig() }.singleton }
}
