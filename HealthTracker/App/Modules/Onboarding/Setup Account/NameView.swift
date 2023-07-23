//
//  NameView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI
import Factory
import CoreData

struct NameView: View {
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    @FocusState private var nameTextFieldFocused: Bool

    var body: some View {
        NavigationView {
            SetupAccountView(title: L10n.Name.title, coloredTitle: L10n.Name.Title.colored, subtitle: L10n.Name.subtitle) {
                if !viewModel.name.isEmpty {
                    withAnimation { viewModel.currentStepIndex += 1 }
                } else {
                    withAnimation { nameTextFieldFocused = true }
                }
            } destination: {
                coordinator.view(router: .name)
                    .environmentObject(viewModel)
                    
            } label: {
                VStack {
                    TextField(L10n.Name.Textfield.placeholder, text: $viewModel.name)
                        .focused($nameTextFieldFocused)
                        .font(.mediumBold)
                        .multilineTextAlignment(.center)
                        .frame(height: 105)
                        .background(Color(.colors.textFieldBackgroundColor))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(nameTextFieldFocused ? Color(.colors.primaryColor) : Color(.colors.secondaryPrimaryColor) , lineWidth: 1.5)
                        }
                        .onTapGesture { }
                }
            }
            .environmentObject(viewModel)
            .onTapGesture { withAnimation { nameTextFieldFocused = false } }
            
        }
        .navigationViewStyle(.stack)

    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
            .environmentObject(SetupAccountViewModel())
    }
}
