//
//  Function.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/13.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation
import CoreGraphics

public func random(from lowerBound: Double, to upperBound: Double, decimal precision: UInt) -> Double {
    let offset = pow(10, Double(precision))
    
    return (Double(arc4random_uniform(UInt32(upperBound * offset - lowerBound * offset))) + lowerBound * offset) / offset
}
public func random(from lowerBound: Int, to upperBound: Int, decimal precision: UInt) -> Double {
    return random(from: Double(lowerBound), to: Double(upperBound), decimal: precision)
}
public func random(from lowerBound: Float, to upperBound: Float, decimal precision: UInt) -> Double {
    return random(from: Double(lowerBound), to: Double(upperBound), decimal: precision)
}
public func random(from lowerBound: CGFloat, to upperBound: CGFloat, decimal precision: UInt) -> Double {
    return random(from: Double(lowerBound), to: Double(upperBound), decimal: precision)
}
