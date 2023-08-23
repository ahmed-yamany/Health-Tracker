//
//  ReminderCoordinator.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 30/07/2023.
//

import SwiftUI
import Factory

extension Container {
    var reminderCoordinator: Factory<ReminderCoordinator> {
        self { ReminderCoordinator() }
            .scope(.shared)
    }
}

enum ReminderCoordinatorRouters: CaseIterable {
    case addTaskGroupButton
}

class ReminderCoordinator: Coordinator {
    typealias Router = ReminderCoordinatorRouters
    
    @ViewBuilder
    public func view(router: Router) -> some View {
        switch router {
        case .addTaskGroupButton:
            AddTodoGroupView()
//                .environmentObject(())
        }
    }

}
