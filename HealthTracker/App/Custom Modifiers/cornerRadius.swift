//
//  cornerRadius.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 28/07/2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
