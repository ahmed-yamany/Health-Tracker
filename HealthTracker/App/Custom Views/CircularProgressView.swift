//
//  CircularProgressView.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(.colors.secondaryPrimaryColor).opacity(0.5),
                    lineWidth: 3
                )
            Circle()
                .trim(from: 0, to: progress) // 1
                .stroke(
                    Color(.colors.secondaryPrimaryColor),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}
