//
//  FlyingFoxReactAppApp.swift
//  FlyingFoxReactApp
//
//  Created by Md Moshiur Rahman on 18/4/24.
//

import SwiftUI
import SwiftData

@main
struct FlyingFoxReactAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}