//
//  SlideModel.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 17/07/2023.
//

import Foundation

struct Slide: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
}
