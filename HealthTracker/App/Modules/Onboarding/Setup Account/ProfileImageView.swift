//
//  ProfileImageView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 19/07/2023.
//

import SwiftUI
import Factory
import PhotosUI

struct ProfileImageView: View {
    @EnvironmentObject var viewModel: SetupAccountViewModel
    @Injected(\.onboardingCoordinator) var coordinator: OnboardingCoordinator
    @Environment(\.managedObjectContext) var viewContext
    @State private var showSheet = false
    @State private var profileImage: Image = Image(systemName: "person")
    @State private var width: CGFloat = 110
    @State private var height: CGFloat = 110
    
    var body: some View {
        SetupAccountView(title: L10n.ProfileImage.title, coloredTitle: L10n.ProfileImage.Title.colored,
                         subtitle: L10n.ProfileImage.subtitle) {
            genNewUser()
        } destination: {
            Text("hi")
        } label: {
            VStack {
                profileImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(Color(.colors.secondaryTextColor))
                        .frame(width: width, height: height)
                        .frame(width: 200, height: 200)
                        .background(Color(.colors.secondaryTextColor).opacity(0.2))
                        .clipShape(Circle())
                        .overlay(alignment: .bottomTrailing) {
                            Button {
                                withAnimation { showSheet = true }
                            } label: {
                                Image(systemName: "plus")
                                    .padding(10)
                                    .background(Color(.colors.primaryColor))
                                    .clipShape(Circle())
                                    .padding(12)
                                    .foregroundColor(.white)
                            }
                        }
                        .background(Circle().stroke(lineWidth: 5).foregroundColor(Color(.colors.primaryColor)))
            }
            .onChange(of: viewModel.image) { newValue in
                width = 200
                height = 200
                profileImage = Image(uiImage: newValue)
            }
        }
        .environmentObject(viewModel)
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
        }
    }
    
    private func genNewUser() {
        let newUser = User(context: viewContext)
        newUser.name = viewModel.name
        newUser.goal = viewModel.goal.title
        newUser.gender = viewModel.gender.rawValue
        newUser.age = Int32(viewModel.age)
        newUser.birthDate = viewModel.birthDate
        newUser.tall = Int32(viewModel.tall) ?? 0
        newUser.image = viewModel.image.pngData()
        do {
            try viewContext.save()
            print("context saved")
        } catch {
            
        }
    }

}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
            .environmentObject(SetupAccountViewModel())
    }
}

