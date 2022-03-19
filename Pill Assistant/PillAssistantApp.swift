//
//  Pill_AssistantApp.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import SwiftUI

@main
struct PillAssistantApp: App {
    
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
    
}
