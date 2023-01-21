//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Josh Buhler on 1/19/23.
//

import SwiftUI

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
