//
//  Health_TrackerApp.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 23/07/2023.
//

import SwiftUI

@main
struct Health_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
