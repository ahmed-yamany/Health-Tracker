//
//  GoalView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI
import Factory

struct GoalView: View {
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    let goals: [UserGoal] = [
        .init(title: "Lose weight", image: .images.setupAccountLoseWeight),
        .init(title: "Gain weight", image: .images.setupAccountGainWeight),
        .init(title: "Stay healty", image: .images.setupAccountStayHealthy)
    ]
    var body: some View {
        SetupAccountView(title: L10n.Goal.title, coloredTitle: L10n.Goal.Title.colored,
                         subtitle: L10n.Goal.subtitle) {
            withAnimation { viewModel.currentStepIndex += 1 }
        } destination: {
            coordinator.view(router: .goal)
                .environmentObject(viewModel)
        } label: {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(goals) { goal in
                        HStack {
                            Text(goal.title)
                            Spacer()
                            Image(goal.image)
                        }
                        .frame(height: 100)
                        .padding(.horizontal)
                        .background(viewModel.goal == goal ? Color(.colors.primaryColor).opacity(0.5) : Color(.colors.textFieldBackgroundColor))
                        .cornerRadius(15)
                        .onTapGesture {
                            withAnimation(.easeInOut) { viewModel.goal = goal }
                        }
                    }
                }
            }
        }
        .environmentObject(viewModel)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            .environmentObject(SetupAccountViewModel())
    }
}
