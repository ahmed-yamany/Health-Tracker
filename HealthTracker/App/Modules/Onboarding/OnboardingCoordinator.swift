//
//  OnboardingCoordinator.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 17/07/2023.
//
import SwiftUI
import Factory

extension Container {
    var onboardingCoordinator: Factory<OnboardingCoordinator> {
        self { OnboardingCoordinator() }
            .scope(.shared)
    }
}

enum OnboardingCoordinatorRouters: CaseIterable {
    case main
    case splash
    case name
    case goal
    case gender
    case birthDate
    case tall
}

class OnboardingCoordinator: Coordinator {
    typealias Router = OnboardingCoordinatorRouters
    
    @ViewBuilder
    public func view(router: Router) -> some View {
        switch router {
        case .main: SplashView()
        case .splash: NameView().environmentObject(SetupAccountViewModel())
        case .name: GoalView()
        case .goal: GenderView()
        case .gender: BirdthDateView()
        case .birthDate: TallView()
        case .tall: ProfileImageView()
        }
    }

}
