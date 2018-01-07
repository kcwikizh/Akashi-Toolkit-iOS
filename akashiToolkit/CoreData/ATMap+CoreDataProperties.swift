//
//  ATMap+CoreDataProperties.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/8.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//
//

import Foundation
import CoreData


extension ATMap {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATMap> {
        return NSFetchRequest<ATMap>(entityName: "ATMap")
    }

    @NSManaged public var id: Int32
    @NSManaged public var numId: Int32
    @NSManaged public var name: String?
    @NSManaged public var level: Int16
    @NSManaged public var infoText: String?
    @NSManaged public var maxHp: Int16
    @NSManaged public var requireDefeatCount: Int16
    @NSManaged public var gain: ATMapResourceModel?
    @NSManaged public var owner: ATArea?
    @NSManaged public var cells: NSSet?

}

// MARK: Generated accessors for cells
extension ATMap {

    @objc(addCellsObject:)
    @NSManaged public func addToCells(_ value: ATMapCell)

    @objc(removeCellsObject:)
    @NSManaged public func removeFromCells(_ value: ATMapCell)

    @objc(addCells:)
    @NSManaged public func addToCells(_ values: NSSet)

    @objc(removeCells:)
    @NSManaged public func removeFromCells(_ values: NSSet)

}
