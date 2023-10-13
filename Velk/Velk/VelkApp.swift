//
//  VelkApp.swift
//  Velk
//
//  Created by Dom Parsons on 17/08/2023.
//

import SwiftUI

@main
struct VelkApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DataController.container.viewContext)
        }
    }
}
