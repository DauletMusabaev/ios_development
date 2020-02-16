//
//  Calculator.swift
//  CalculatorProject
//
//  Created by erumaru on 1/25/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Constants
    enum Operation {
        case equals
        case constant(value: Double)
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
        case clear
    }
    
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "*" : .binary { $0 * $1 },
        "=" : .equals,
        "-" : .binary { $0 - $1 },
        "/" : .binary { $0 / $1 },
        "%" : .unary { $0 / 100 },
        "√" : .unary { sqrt($0) },
        "π" : .constant (value: Double.pi),
        "RND" : .constant (value: Double.random(in: 0 ..< 100) ),
        "x^y" : .binary {pow( $0, $1 )},
        "x!" : .unary { factorial($0) },
        "AC" : .clear,
        "C": .constant (value: 0)
        
    ]
        
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    static func factorial(_ factorialNumber: Double) -> Double {
        if factorialNumber == 0 {
            return 1
        } else {
            return factorialNumber * factorial(factorialNumber - 1)
        }
    }
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }
        
        switch operation {
        case .clear:
            result = 0
            lastBinaryOperation = nil
            reminder = 0
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary(let function):
            if lastBinaryOperation != nil {
                executeOperation(symbol: "=")
            }
            
            lastBinaryOperation = function
            reminder = result
            
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                lastBinaryOperation = nil
                reminder = 0
            }
        }
    }
}
