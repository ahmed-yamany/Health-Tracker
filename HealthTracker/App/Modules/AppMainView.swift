//
//  AppMainView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 23/07/2023.
//

import SwiftUI
import Factory

struct AppMainView: View {
    @Injected(\.onboardingCoordinator) var coordinator
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.id, ascending: true)],
        animation: .default) private var users: FetchedResults<User>
    
    
    var body: some View {
        if let _ = users.last {
            MainTabView()
        } else {
            coordinator.view(router: .main)
        }
    }
}

