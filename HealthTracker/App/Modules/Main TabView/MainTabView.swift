//
//  MainTabView.swift
//  Food-Recipe-SwiftUi
//
//  Created by Ahmed Yamany on 11/07/2023.
//

import SwiftUI

enum MainTabViewTabs: String, CaseIterable {
    case food = "fork.knife.circle"
    case sleep = "powersleep"
    case home = "house"
    case activities = "dumbbell.fill"
    case reminder = "clock"
}

struct MainTabView: View {
    @State private var selectedTab: MainTabViewTabs = .home
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
            TabView(selection: $selectedTab) {
               FoodView()
                    .tag(MainTabViewTabs.food)
                
                SleepView()
                    .tag(MainTabViewTabs.sleep)
                
                HomeView()
                    .tag(MainTabViewTabs.home)
                
                ActivitiesView()
                    .tag(MainTabViewTabs.activities)
                
                ReminderView()
                    .tag(MainTabViewTabs.reminder)
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
    @Namespace var namespace
    
    var body: some View {
        HStack {
            ForEach(MainTabViewTabs.allCases, id: \.self) { tab in
                GeometryReader { reader in
                    Button {
                        withAnimation {
                            selectedTab = tab
                        }
                    } label: {
                        if tab != .home {
                            Image(systemName: tab.rawValue)
                                .font(Font.system(size: 22))
                                .foregroundColor(tab == selectedTab ? Color(.colors.primaryColor) : Color(.colors.secondaryTextColor))
                                .frame(maxWidth: .infinity)
                                .padding(.top)
                        } else {
                            Image(systemName: "house")
                                .font(Font.largeBold)
                                .frame(width: 55, height: 55)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background { Circle().foregroundColor(Color(.colors.primaryColor)) }
                                .onAppear {
                                    xAxis = reader.frame(in: .global).midX
                                }
                        }
                    }
                    .offset(y: tab == .home ? -25 : 0)
                    .offset(y: tab == selectedTab && tab != .home ? -10 : 0)
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
