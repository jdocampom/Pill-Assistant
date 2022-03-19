//
//  DataController.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import CoreData
import SwiftUI

final class DataController: ObservableObject {
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("❌ FATAL ERROR LOADING DATA MODEL - DataController - ERROR: \(error.localizedDescription) ❌")
            }
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("❌ FATAL ERROR CREATING PREVIEW DATA MODEL - DataController - ERROR: \(error.localizedDescription) ❌")
        }
        return dataController
    }()
    
    func createSampleData () throws {
        let viewContext = container.viewContext
        let medications = ["Paracetamol", "Ibuprofen", "Naproxen", "Vicodin", "Excedrin"]
        for item in medications {
            let medication = Medication(context: viewContext)
            medication.name = item
            medication.summary = "Sample data for \(item)"
            medication.creationDate = Date() + Double(3600 * Int.random(in: 1...5))
            medication.scheduled = Bool.random()
            medication.currentStock = Int16.random(in: 50...200)
            medication.concentration = Double(Int.random(in: 20...500))
            for _ in 1...10 {
                let dose = Dose(context: viewContext)
                dose.date = Date()
                dose.count = Int16.random(in: 1...3)
                dose.medication = medication
            }
        }
        try viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func clearAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Medication.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Dose.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }
    
}

