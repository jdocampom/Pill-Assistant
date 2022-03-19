//
//  MedicationsView.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import SwiftUI

struct MedicationsView: View {
    
    static let scheduledTag: String? = "Scheduled"
    static let nonScheduledTag: String? = "Not Scheduled"
    
    let showScheduledMedications: Bool
    let medications: FetchRequest<Medication>
    
    init(showScheduledMedications: Bool) {
        self.showScheduledMedications = showScheduledMedications
        medications = FetchRequest<Medication>(entity: Medication.entity(),
                                               sortDescriptors: [NSSortDescriptor(keyPath: \Medication.creationDate, ascending: false)],
                                         predicate: NSPredicate(format: "scheduled = %d", showScheduledMedications))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(medications.wrappedValue) { medication in
                    Section(header: Text("\(medication.title) - Scheduled: \(String(medication.scheduled))")) {
                        ForEach(medication.pillsTaken) { item in
                            Text(item.dateTaken.formatted())
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showScheduledMedications ? "Scheduled" : "Not Scheduled")
        }
    }
    
}

struct MedicationsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
        MedicationsView(showScheduledMedications: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
