//
//  MacPuf2022PApp.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.
//

import SwiftUI

@main
struct MacPuf2022PApp: App {
    private let simulator = Simulator()
    var body: some Scene {
        WindowGroup {
            ContentView(simulator:simulator)
        }
    }
}
