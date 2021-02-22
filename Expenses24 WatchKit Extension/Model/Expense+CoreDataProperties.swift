//
//  Expense+CoreDataProperties.swift
//  Expenses24
//
//  Created by jassak on 19/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var info: String?
    @NSManaged public var color: String?
    @NSManaged public var value: Double

    var myDate:Date{
        date ?? Date()
    }
    var myType:String{
        type ?? "NA"
    }
    var myInfo:String{
        info ?? "NA"
    }
    var myColor:String{
        color ?? "MiscBG"
    }
}

extension Expense : Identifiable {

}
