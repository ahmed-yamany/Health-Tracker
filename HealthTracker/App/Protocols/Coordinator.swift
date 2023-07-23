//
//  Coordinator.swift
//  Health Tracker
//
//  Created by Ahmed Yamany on 18/07/2023.
//

import SwiftUI


public protocol Coordinator {
    associatedtype V: View
    associatedtype Router
    
    @ViewBuilder
    func view(router: Router) -> V
}
