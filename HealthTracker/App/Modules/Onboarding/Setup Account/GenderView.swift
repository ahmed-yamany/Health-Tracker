//
//  GenderView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI
import Factory


struct GenderView: View {
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    
    
    var body: some View {
        SetupAccountView(title: L10n.Gender.title, coloredTitle: L10n.Gender.Title.colored,
                         subtitle: L10n.Gender.subtitle) {
            withAnimation { viewModel.currentStepIndex += 1 }
        } destination: {
            coordinator.view(router: .gender)
                .environmentObject(viewModel)
        } label: {
            HStack(spacing: 15.0) {
                genderView(image: .images.male, title: L10n.Gender.male, type: .male)
                genderView(image: .images.female, title: L10n.Gender.female, type: .female)
            }
            .frame(maxWidth: .infinity)
        }
        .environmentObject(viewModel)
    }
    
    private func genderView(image: String, title: String, type: Genders) -> some View {
        VStack {
            Image(image)
            Text(title)
                .font(.mediumBold)
                .foregroundColor(type == viewModel.gender ? .white : Color(.colors.primaryTextColor))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
        .background(type == viewModel.gender ? Color(.colors.primaryColor) : Color(.colors.textFieldBackgroundColor))
        .cornerRadius(15)
        .onTapGesture {
            withAnimation(.easeInOut) { viewModel.gender = type }
        }
    }
}


struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView()
            .environmentObject(SetupAccountViewModel())
    }
}
