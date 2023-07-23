//
//  SetupAccountView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI
import Factory

struct SetupAccountView<Destination, Label>: View where Destination: View, Label: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    @State private var navigationIsActive = false
    // MARK: - Intializers properties
    let title: String
    let coloredTitle: String
    let subtitle: String
    let action: () -> Void
    let destination: () -> Destination
    let label: () -> Label
    
    var btnBack : some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.currentStepIndex -= 1
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .padding(10)
                    .background(Color(.colors.textFieldBackgroundColor))
                    .foregroundColor(Color(.colors.secondaryPrimaryColor))
                    .clipShape(Circle())
                    
            }
        }
    }
    var body: some View {
        VStack(spacing: 15.0) {
            VStack {
                Group {
                    Text("\(Int(viewModel.currentStepIndex))") +
                    Text("/\(Int(viewModel.stepsCount))")
                        .foregroundColor(Color(.colors.secondaryTextColor))
                }
                .font(.smallBold)
                Group {
                    Text(title) +
                    Text(coloredTitle)
                        .foregroundColor(Color(.colors.primaryColor))
                }
                .font(.headerBold)
                
                Text(subtitle)
                    .multilineTextAlignment(.center)
                    .font(.smallRegular)
                    .frame(width: 204)
                    .foregroundColor(Color(.colors.secondaryTextColor))
            }
            .padding(.top, 50)
            
            Spacer()
            
            label()
            
            Spacer()
            
            NavigationLink(destination: destination(), isActive: $navigationIsActive) {
                Button {
                    action()
                } label: {
                    Text("\(Image(systemName: "chevron.right"))")
                        .font(.headline)
                        .frame(width: 66, height: 66)
                        .background(Color(.colors.secondaryPrimaryColor))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .background(
                            CircularProgressView(progress: viewModel.currentStepIndex / viewModel.stepsCount)
                                .padding(-10)
                                .onAnimationCompleted(for: viewModel.currentStepIndex) {
                                    navigationIsActive = true
                                }
                        )
                }
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.colors.appBackgroundColor))
        .foregroundColor(Color(.colors.primaryTextColor))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
}

struct SetupAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SetupAccountView(title: "What is your ",
                         coloredTitle: "Name?",
                         subtitle: "We will use this data to give you a better diet type for you",
         action: {
            
        }, destination: { Text("hello")}, label: {
            Text("hello")
        })
        .environmentObject(SetupAccountViewModel())
    }
}
