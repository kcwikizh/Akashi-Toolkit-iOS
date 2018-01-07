//
//  ATArea+CoreDataProperties.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/8.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//
//

import Foundation
import CoreData


extension ATArea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATArea> {
        return NSFetchRequest<ATArea>(entityName: "ATArea")
    }

    @NSManaged public var name: String?
    @NSManaged public var isSpecial: Bool
    @NSManaged public var id: Int32
    @NSManaged public var maps: NSOrderedSet?

}

// MARK: Generated accessors for maps
extension ATArea {

    @objc(insertObject:inMapsAtIndex:)
    @NSManaged public func insertIntoMaps(_ value: ATMap, at idx: Int)

    @objc(removeObjectFromMapsAtIndex:)
    @NSManaged public func removeFromMaps(at idx: Int)

    @objc(insertMaps:atIndexes:)
    @NSManaged public func insertIntoMaps(_ values: [ATMap], at indexes: NSIndexSet)

    @objc(removeMapsAtIndexes:)
    @NSManaged public func removeFromMaps(at indexes: NSIndexSet)

    @objc(replaceObjectInMapsAtIndex:withObject:)
    @NSManaged public func replaceMaps(at idx: Int, with value: ATMap)

    @objc(replaceMapsAtIndexes:withMaps:)
    @NSManaged public func replaceMaps(at indexes: NSIndexSet, with values: [ATMap])

    @objc(addMapsObject:)
    @NSManaged public func addToMaps(_ value: ATMap)

    @objc(removeMapsObject:)
    @NSManaged public func removeFromMaps(_ value: ATMap)

    @objc(addMaps:)
    @NSManaged public func addToMaps(_ values: NSOrderedSet)

    @objc(removeMaps:)
    @NSManaged public func removeFromMaps(_ values: NSOrderedSet)

}
