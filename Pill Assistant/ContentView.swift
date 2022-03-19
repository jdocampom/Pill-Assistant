//
//  ContentView.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?
    var body: some View {
        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            MedicationsView(showScheduledMedications: true)
                .tag(MedicationsView.scheduledTag)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Scheduled")
                }
            
            MedicationsView(showScheduledMedications: false)
                .tag(MedicationsView.nonScheduledTag)
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Not Scheduled")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
