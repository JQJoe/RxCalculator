//
//  CalculatorAction.swift
//  RxCalculator
//
//  Created by Joe_Liu on 17/2/13.
//  Copyright © 2017年 Joe_Liu. All rights reserved.
//

import Foundation

enum Action {
    case clear
    case changeSign
    case percent
    case operation(Operator)
    case equal
    case addNumber(Character)
    case addDot
}
