//
//  TallView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 19/07/2023.
//

import SwiftUI
import Factory

struct TallView: View {
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    @FocusState var tallTextFieldFocused: Bool
    var body: some View {
        SetupAccountView(title: L10n.Tall.title, coloredTitle: L10n.Tall.Title.colored,
                         subtitle: L10n.Tall.subtitle) {
            if viewModel.tall.isEmpty {
                tallTextFieldFocused = true
            } else {
                withAnimation { viewModel.currentStepIndex += 1 }
            }
        } destination: {
            coordinator.view(router: .tall)
        } label: {
            TextField(L10n.Tall.Textfield.placeholder, text: $viewModel.tall)
                .keyboardType(.numberPad)
                .focused($tallTextFieldFocused)
                .font(.mediumBold)
                .multilineTextAlignment(.center)
                .frame(height: 105)
                .background(Color(.colors.textFieldBackgroundColor))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(tallTextFieldFocused ? Color(.colors.primaryColor) : Color(.colors.secondaryPrimaryColor) , lineWidth: 1.5)
                }
                .onTapGesture { }
        }
        .environmentObject(viewModel)
        .onTapGesture {
            tallTextFieldFocused = false
        }
    }

}

struct TallView_Previews: PreviewProvider {
    static var previews: some View {
        TallView()
            .environmentObject(SetupAccountViewModel())
    }
}
