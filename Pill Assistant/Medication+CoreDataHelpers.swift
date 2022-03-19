//
//  Medication+CoreDataHelpers.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import Foundation

extension Medication {
    
    var title:   String { name ?? "" }
    var notes:   String { summary ?? "" }
    var date:    Date { creationDate ?? Date() }
    var repeats: Bool { scheduled }
    var dosage:  Double { concentration }
    var count :  Int16 { currentStock }
    
    //    var projectCompletion:   Bool { completed ?? false }
    
    var pillsTaken: [Dose] {
        let dosesArray = doses?.allObjects as? [Dose] ?? []
        return dosesArray.sorted { first, second in
            return first.dateTaken < second.dateTaken
        }
    }
    
    static var example: Medication {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        let medication = Medication(context: viewContext)
        medication.name = "Dyphenhydramine"
        medication.summary = "Sleeping pills."
        medication.creationDate = Date()
        medication.currentStock = 200
        medication.scheduled = false
        medication.concentration = 50
        return medication
    }
    
}

