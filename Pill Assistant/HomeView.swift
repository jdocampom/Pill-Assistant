//
//  HomeView.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import SwiftUI

struct HomeView: View {
    
    static let tag: String? = "Home"
    
    @EnvironmentObject
    private var dataController: DataController
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.clearAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
