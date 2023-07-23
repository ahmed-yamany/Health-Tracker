//
//  MainTabView.swift
//  Food-Recipe-SwiftUi
//
//  Created by Ahmed Yamany on 11/07/2023.
//

import SwiftUI

enum MainTabViewTabs: String, CaseIterable {
    case home, saved, plus, notification, profile
}

struct MainTabView: View {
    @State private var selectedTab: MainTabViewTabs = .home
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
            TabView(selection: $selectedTab) {
                Text("Home")
                    .tag(MainTabViewTabs.home)
                Text("Saved")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.blue)
                    .tag(MainTabViewTabs.saved)
                Text("Notifications")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.yellow)
                    .tag(MainTabViewTabs.notification)
                Text("Profile")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
                    .tag(MainTabViewTabs.profile)
            }
            .overlay(alignment: .bottom) {
                TabBarView(selectedTab: $selectedTab)
            }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

struct TabBarView: View {
    @Binding var selectedTab: MainTabViewTabs
    @State private var xAxis: CGFloat = 0
    var body: some View {
        HStack {
            ForEach(MainTabViewTabs.allCases, id: \.self) { tab in
                GeometryReader { reader in
                    Button {
                        if tab == .plus {

                        } else {
                            selectedTab = tab
                        }
                    } label: {
                        if tab != .plus {
                            Image("icon\(tab.rawValue.capitalized)")
                                .frame(maxWidth: .infinity)
                                .padding(.top)
                        } else {
                            Image(systemName: "plus")
//                                .fontWeight(.bold)
                                .frame(width: 55, height: 55)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background { Circle().foregroundColor(.primary) }
                                .onAppear {
                                    xAxis = reader.frame(in: .global).midX
                                }
                        }
                    }
                    .offset(y: tab == .plus ? -25 : 0)
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity)
        .background(
            Color(.colors.appBackgroundColor)
                .clipShape(TabBarCurveShape(xAxis: xAxis))
                .ignoresSafeArea()
                .shadow(radius: 2)
        )
    }
}
