//
//  CellView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2018/9/1.
//  Copyright © 2018年 kcwikizh. All rights reserved.
//

import UIKit

enum CellViewLineType {
    case none                   ///<不显示任何分割线
    case bothLong               ///<上下都长(单独cell
    case topHideBottomShort     ///<上隐藏下短(大部分cell
    case topLongBottomShort     ///<上长下短(大多数时候作为第一个cell
    case topHideBottomLong      ///<上隐藏下长(大多数时候作为最后一个cell
}

class CellView: UIView {

    // MARK: *** 属性 ***
}
