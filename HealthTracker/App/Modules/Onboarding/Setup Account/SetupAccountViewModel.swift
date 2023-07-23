//
//  SetupAccountViewModel.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import Foundation
import SwiftUI


final class SetupAccountViewModel: ObservableObject, Identifiable {
    let stepsCount: Double = Double(OnboardingCoordinatorRouters.allCases.count)
    @Published var currentStepIndex: Double = 1
    @Published var name: String = ""
    @Published var goal: UserGoal = .init(title: "", image: "")
    @Published var gender: Genders = .male
    @Published var age: Int = 0
    @Published var birthDate: Date = Date.now
    @Published var tall: String = ""
    @Published var image: UIImage = UIImage()
}
