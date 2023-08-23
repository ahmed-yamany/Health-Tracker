//
//  Health_TrackerApp.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 23/07/2023.
//

import SwiftUI
import Factory
@main
struct Health_TrackerApp: App {
    @Injected(\.appCoordinator) var coordinator
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            coordinator.view(router: true)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(ColorScheme(.light))
        }
    }
}
