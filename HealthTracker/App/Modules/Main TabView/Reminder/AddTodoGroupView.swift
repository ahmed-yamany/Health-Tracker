//
//  AddTodoGroupView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 29/07/2023.
//

import SwiftUI
import Factory
struct AddTodoGroupView: View {
    @StateObject var viewModel: AddTodoGroupViewModel = AddTodoGroupViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var viewContext
    
    @FocusState var titleIsFocus: Bool
    @State var imagesIsFocus: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 28.0) {
                    
                    TextField("\(L10n.Tabview.Reminder.AddTodoGroup.Textfiled.placeholder)",
                              text: $viewModel.title)
                    .applyStyle(.primary,
                                title: L10n.Tabview.Reminder.AddTodoGroup.Textfiled.title,
                                isFocused: titleIsFocus)
                    .focused($titleIsFocus)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 30) {
                            ForEach(viewModel.todogroupImagesSystemName, id: \.self) { imageSystemName in
                                ZStack(alignment: .bottomTrailing) {
                                    Image(systemName: imageSystemName)
                                        .font(Font.headerBold)
                                        .onTapGesture {
                                            viewModel.imageSystemName = imageSystemName
                                        }
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(viewModel.imageSystemName == imageSystemName ?
                                                             Color(.colors.primaryColor) : Color.clear)
                                            .padding(-12)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .frame(height: screenBounds().height / 2.5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke()
                            .foregroundColor(imagesIsFocus ?
                                             Color(.colors.primaryColor) : Color(.colors.primaryTextColor))
                    }
                    
                    
                    Button {
                        saveButtonAction()
                    } label: {
                        Text("\(L10n.Tabview.Reminder.AddTodoGroup.saveButton)")
                            .font(Font.mediumBold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.colors.primaryColor))
                            .foregroundColor(Color(.colors.buttonForgroundColor))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.colors.appBackgroundColor))
            .navigationTitle("\(L10n.Tabview.Reminder.AddTodoGroup.navigationtitle)")
            .foregroundColor(Color(.colors.primaryTextColor))
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
    
    private func saveButtonAction() {
        if viewModel.title.isEmpty {
            titleIsFocus = true
        } else if viewModel.imageSystemName.isEmpty {
            imagesIsFocus = true
        } else {
            presentationMode.wrappedValue.dismiss()
            withAnimation {
                viewModel.saveToCoreData(context: viewContext)
            }
        }
    }

}

struct AddTodoGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoGroupView()
    }
}

func screenBounds() -> CGRect {
    UIScreen.main.bounds
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
