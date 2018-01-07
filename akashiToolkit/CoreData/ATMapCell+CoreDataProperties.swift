//
//  ATMapCell+CoreDataProperties.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/1/8.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//
//

import Foundation
import CoreData


extension ATMapCell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATMapCell> {
        return NSFetchRequest<ATMapCell>(entityName: "ATMapCell")
    }

    @NSManaged public var id: Int32
    @NSManaged public var numId: Int32
    @NSManaged public var type: Int16
    @NSManaged public var owner: ATMap?

}
