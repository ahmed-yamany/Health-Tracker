//
//  UserGoal.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 21/07/2023.
//

import Foundation

struct UserGoal: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let image: String
}
