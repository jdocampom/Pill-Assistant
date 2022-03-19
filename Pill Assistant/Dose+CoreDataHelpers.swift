//
//  Dose+CoreDataHelpers.swift
//  Pill Assistant
//
//  Created by Juan Diego Ocampo on 19/03/22.
//

import Foundation

extension Dose {
    
    var pillsTaken: Int16 { count }
    var dateTaken:  Date { date ?? Date() }

    static var example: Dose {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        let dose = Dose(context: viewContext)
        dose.date = Date()
        dose.count = 2
        return dose
    }
    
}
