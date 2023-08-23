//
//  ReminderView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 28/07/2023.
//

import SwiftUI
import Factory
struct ReminderView: View {
    @Injected(\.reminderCoordinator) var coordinator: ReminderCoordinator
    
    @State private var todayText: String = ""
    @State private var searchText: String = ""
    @State private var selectedIndex: Int = 0
    @State private var showAddTaskGroup: Bool = false
    @State private var showTaskGroup: Bool = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoGroup.id, ascending: true)],
        animation: .default) private var todogroups: FetchedResults<TodoGroup>

    var body: some View {
        GeometryReader { geometryProxy in
            
            VStack {
                // MARK: - header & search
                HeaderView(geometryProxy: geometryProxy)
                // MARK: - Task Groups
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20.0) {
                        FilterView()
                        TodoGroupView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .cornerRadius(35, corners: [.topLeft, .topRight])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.colors.primaryColor))
            .foregroundColor(Color(.colors.primaryTextColor))
            .ignoresSafeArea()
            .sheet(isPresented: $showAddTaskGroup) {
                coordinator.view(router: .addTaskGroupButton)
            }
            .onAppear {
                updateDateText()
            }
        }
    }
    
    //  MARK: - Private Views
    private func HeaderView(geometryProxy: GeometryProxy) -> some View {
        VStack(spacing: 20.0) {
            VStack {
                Group {
                    Text("\(L10n.Tabview.Reminder.Title.youHave)") +
                    Text(" \(todogroups.count) \(L10n.Tabview.Reminder.Title.tasks) ")
                        .foregroundColor(.white).font(Font.headerBold) +
                    Text("\(L10n.Tabview.Reminder.Title.today)")
                }
                .font(Font.headerRegular)
                
                Text(todayText)
                    .font(Font.normalRegular)
            }
            .padding(.top, geometryProxy.safeAreaInsets.top)

            HStack {
                Image(systemName: "magnifyingglass")
                TextField("\(L10n.Tabview.Reminder.Search.placeholder)", text: $searchText)
            }
            .foregroundColor(Color(.colors.primaryTextColor))
            .padding(.horizontal)
            .frame(width: 280, height: 48)
            .background(Color(.colors.appBackgroundColor))
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: geometryProxy.size.height / 3.2)
        .foregroundColor(Color(.colors.primaryTextColor))
        .background(CirclesView())
        
    }
    
    private func CirclesView() -> some View {
        ZStack {
            LinearGradient(colors: [.purple, .purple.opacity(0.5), Color(.colors.primaryColor)], startPoint: .top, endPoint: .bottom)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.trailing)
                .offset(y: -20)
                .ignoresSafeArea()
            
            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                .frame(width: 30, height: 30)
                .blur(radius: 3)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
            
            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                .frame(width: 30, height: 30)
                .blur(radius: 3)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
        }
    
    }
    
    private func FilterView() -> some View {
        HStack {
            ForEach(0..<3, id: \.self) { index in
                Text("Hello")
                    .foregroundColor(index == selectedIndex ?
                                     Color(.colors.appBackgroundColor) :
                                        Color(.colors.primaryTextColor))
                    .frame(width: 75, height: 27)
                    .background(index == selectedIndex ?
                                Color(.colors.primaryColor) :
                                    Color.clear)
                    .cornerRadius(14)
                    .overlay {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke()
                            .foregroundColor(Color(.colors.primaryColor))
                    }
                    .onTapGesture { withAnimation { selectedIndex = index } }
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func TodoGroupView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(100)), count: 3)) {
            ForEach(todogroups, id: \.id) { todogroup in
                ZStack(alignment: .topTrailing) {
                    VStack(spacing: 10.0) {
                        Image(systemName: todogroup.imageSystemName ?? "")
                        Text(todogroup.title ?? "")
                    }
                    .foregroundColor(Color(.colors.appBackgroundColor))
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: todogroup.color?.red ?? 0,
                                      green: todogroup.color?.green ?? 0,
                                      blue: todogroup.color?.blue ?? 0))
                    .cornerRadius(14)
                    
                    Text("5")
                        .foregroundColor(Color(.colors.appBackgroundColor))
                        .frame(width: 24, height: 24)
                        .background(Circle()
                            .foregroundColor(Color(.colors.primaryColor)))
                        .padding(-5)
                }
                .onTapGesture {
                    showTaskGroup = true
                }
            }
            
            AddGroupButton()
                
        }
    }
    
    private func AddGroupButton() -> some View {
        Button {
            withAnimation { showAddTaskGroup.toggle() }
        } label: {
            Image(systemName: "plus")
                .font(Font.titleRegular)
                .foregroundColor(Color(.colors.primaryColor))
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke()
                        .foregroundColor(Color(.colors.primaryColor))
                }
        }
    }
    
    //  MARK: -
    private func updateDateText() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let timeString = dateFormatter.string(from: Date.now)
        todayText = timeString
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
