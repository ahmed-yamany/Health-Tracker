//
//  SlideScreen.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 17/07/2023.
//

import SwiftUI
import Factory
import CoreData

extension FetchedResults<User> {
    var user: User? {
        self.first
    }
}




struct SplashView: View {
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    @State private var selectedSlideIndex: Int = 0
    @State private var slides: [Slide] = [
        .init(image: .images.splashCooking, title: L10n.Splash.Cooking.title, subtitle: L10n.Splash.Cooking.subtitle),
        .init(image: .images.splashGym, title: L10n.Splash.Gym.title, subtitle: L10n.Splash.Gym.subtitle),
        .init(image: .images.splashSleeping, title: L10n.Splash.Sleeping.title, subtitle: L10n.Splash.Sleeping.subtitle),
        .init(image: .images.splashReminder, title: L10n.Splash.Reminder.title, subtitle: L10n.Splash.Reminder.subtitle)
    ]
    @State private var shouldCoordinate: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.id, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        VStack {
            TabView(selection: $selectedSlideIndex) {
                ForEach(0..<slides.count, id: \.self) { index in
                    let slide = slides[index]
                    VStack(alignment: .leading) {
                        Image(slide.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .padding(.bottom, 40)
                        
                        Text(slide.title)
                            .font(.titleBold)
                        Text(slide.subtitle)
                            .font(.mediumRegular)
                            .foregroundColor(Color(.colors.secondaryTextColor))
                    }
                    .padding(30)
                }
            }
            .tabViewStyle(.page)

            navigationButton()
                .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.colors.appBackgroundColor))
        .foregroundColor(Color(.colors.primaryTextColor))
        .fullScreenCover(isPresented: $shouldCoordinate, content: { coordinator.view(router: .splash) })
    }
    
    @ViewBuilder
    private func navigationButton() -> some View {
        HStack {
            HStack {
                ForEach(0..<slides.count, id: \.self) { index in
                    Capsule()
                        .frame(width: selectedSlideIndex == index ? 24 : 10, height: 10)
                        .foregroundColor(index == selectedSlideIndex ?  Color(.colors.primaryColor) : .gray)
                }
            }
            Spacer()
            Button {
                if selectedSlideIndex < slides.count - 1 {
                    withAnimation(.easeIn) {
                        selectedSlideIndex += 1
                    }
                } else {
                    withAnimation {
                        shouldCoordinate = true
                    }
                }
                
            } label: {
                Text(selectedSlideIndex < slides.count - 1 ? "\(Image(systemName: "chevron.right"))" : "\(L10n.Splash.Button.title)")
                    .font(.headline)
                    .frame(width: selectedSlideIndex < slides.count - 1 ? 50 : 140, height: 50)
                    .background(Color(.colors.secondaryPrimaryColor))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
            }
        }
        .frame(height: 50)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
