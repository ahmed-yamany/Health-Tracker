//
//  BirdthDateView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI
import Factory

struct BirdthDateView: View {
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    
    var body: some View {
        SetupAccountView(title: L10n.BirthDate.title, coloredTitle: L10n.BirthDate.Title.colored,
                         subtitle: L10n.BirthDate.subtitle) {
            if viewModel.age != 0 {
                withAnimation { viewModel.currentStepIndex += 1 }
            }
        } destination: {
            coordinator.view(router: .birthDate)
                .environmentObject(viewModel)
        } label: {
            VStack(spacing: 15.0) {
                Text("\(viewModel.age)")
                    .font(.titleBold)
                    .multilineTextAlignment(.center)
                    .frame(height: 105)
                    .frame(maxWidth: .infinity)
                    .background(Color(.colors.textFieldBackgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                DatePicker("\(Image(systemName: "calendar"))",
                           selection: .init(get: { viewModel.birthDate}, set: { value in
                    let calender = Calendar.current
                    let selectedYear = calender.dateComponents([.year], from: value).year ?? 0
                    let currentYear = calender.dateComponents([.year], from: Date.now).year ?? 0
                    viewModel.age = currentYear - selectedYear
                    viewModel.birthDate = value
                }), displayedComponents: .date)
                    .accentColor(Color(.colors.primaryColor))
                    .frame(height: 50)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.colors.textFieldBackgroundColor))
                            .opacity(0.8)
                    )
            }
            .frame(maxWidth: .infinity)
        }
        .environmentObject(viewModel)
    }
}

struct BirdthDateView_Previews: PreviewProvider {
    static var previews: some View {
        BirdthDateView()
            .environmentObject(SetupAccountViewModel())
        
    }
}
