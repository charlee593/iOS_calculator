//
//  calculatorBrain.swift
//  Calculator
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 School. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var historyStackAndValue: [Dictionary<String,String>] = []
    private var accumulator: Double?
    // accumulator can either have an operand or a number...
    var variableValues = Dictionary<String, Double>()
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation ((Double, Double) -> Double)
        case equals
        // in a binaryOperation... you need to take 2 parameters and return
        // a double the -> points to the type it returns
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({-$0}),
        "x" : Operation.binaryOperation({$0 * $1}),
        "/" : Operation.binaryOperation({$0 / $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "^" : Operation.binaryOperation({pow($0 , $1)}),
        "sin" : Operation.unaryOperation(sin),
        "tan" : Operation.unaryOperation(tan),
        "=" : Operation.equals
    ]
    mutating func setOperand(variableName: String){
        variableValues[variableName] = 0.0
    }
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case.unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                
            case .binaryOperation (let function):
                if accumulator != nil{
                    
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                }
            case .equals:
                performPendingBinaryOperation()
                break
            }
            
        }
        
    }
    
    private mutating func performPendingBinaryOperation() {
        pendingBinaryOperation?.perform(with: accumulator!)
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
            
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation? //this is  a cheat...
    // 5 times.... ???  is a pending operation because we don't have
    // second operand yet... otherwise it isn't a pending operation
    private struct PendingBinaryOperation {
        var function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func clearStack() {
        accumulator = nil
        pendingBinaryOperation = nil
        historyStackAndValue = []
        
    }
    
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func stackPush (historyDisplay : String, display: String){
        var dic = ["history": historyDisplay]
        dic["display"] = display
        historyStackAndValue.append(dic)
    }
    mutating func stackPop() -> Dictionary<String, String> {
        if !historyStackAndValue.isEmpty{
        return historyStackAndValue.popLast()!
        }
       return [:]
    }
    
    
}

