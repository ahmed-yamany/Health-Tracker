//
//  AppCoordinator.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 23/07/2023.
//

import SwiftUI
import Factory

extension Container {
    var appCoordinator: Factory<AppCoordinator> {
        self { AppCoordinator() }
            .scope(.unique)
    }
}


struct AppCoordinator: Coordinator {
    @Injected(\.onboardingCoordinator) var coordinator

    typealias Router = Bool

    @ViewBuilder
    public func view(router: Router) -> some View {
        AppMainView()
    }
    
    
}
