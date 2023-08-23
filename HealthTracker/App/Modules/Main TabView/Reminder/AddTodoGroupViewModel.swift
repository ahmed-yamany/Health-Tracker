//
//  AddTaskGroupViewModel.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 30/07/2023.
//

import SwiftUI
import Factory
import CoreData

class AddTodoGroupViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var imageSystemName: String = ""
    @Published var color: Color = Color(red: .random(in: 0...0.8),
                                        green: .random(in: 0...0.8),
                                        blue: .random(in: 0...0.8))
    
    let todogroupImagesSystemName = [
        "heart.fill",
        "cross.case.fill",
        "bed.double.fill",
        "pills.fill",
        "brain.head.profile",
        "alarm.fill",
        "hourglass.bottomhalf.filled",
        "bag.fill",
        "cart.fill",
        "creditcard.fill",
        "dollarsign.circle.fill",
        "play.rectangle",
        "pencil",
        "globe.americas.fill",
        "figure.walk",
        "lightbulb.fill",
        "car.fill",
        "airplane.departure"
    ]
    
    public func saveToCoreData(context: NSManagedObjectContext) {
        let todoGroup = TodoGroup(context: context)
        todoGroup.id = UUID()
        todoGroup.title = title
        todoGroup.imageSystemName = imageSystemName
        let groupColor = TGColor(context: context)
        groupColor.id = UUID()
        todoGroup.color = groupColor
        groupColor.red = color.components.red
        groupColor.green = color.components.green
        groupColor.blue = color.components.blue
        groupColor.opacity = color.components.opacity
        try? context.save()
    }
}

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }

    var hex: String {
        String(
            format: "#%02x%02x%02x%02x",
            Int(components.red * 255),
            Int(components.green * 255),
            Int(components.blue * 255),
            Int(components.opacity * 255)
        )
    }
}
