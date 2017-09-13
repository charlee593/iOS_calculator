//
//  ViewController.swift
//  Calculator
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 School. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var historyDisplay: UILabel!
    
    var displayStack = ""
    
    var userIsInTheMiddleOfTyping = false
    
    var memory : Double = 0
    
    @IBAction func MC(_ sender: UIButton) {
        memory = 0
    }
    
    @IBAction func MR(_ sender: UIButton) {
        display!.text = String(memory)
        userIsInTheMiddleOfTyping = true
        historyDisplay!.text = historyDisplay!.text! + String(memory)
        //        displayValue = memory
    }
    
    @IBAction func MS(_ sender: UIButton) {
        
        
        memory = Double(display.text!)!
    }
    
    @IBAction func M(_ sender: UIButton) {
        
        memory = memory + Double(display.text!)!
        //        displayValue = memory
        display!.text = String(memory)
    }
    @IBAction func clear(_ sender: Any) {
        display.text = "0"
        
        
    }
    
    @IBAction func clearStack(_ sender: Any) {
        display.text = "0"
        historyDisplay.text = ""
        brain.clearStack()
        displayStack = ""
        
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        displayStack =  displayStack + digit
        historyDisplay.text = displayStack
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            //            if digit == "0" && display.text == "0" {
            //                return
            //            }
            //            if display.text == "0" && digit != "0"{
            //
            //                return
            //            }
            if digit  != "." || textCurrentlyInDisplay.range(of:".") == nil {
                displayStack =  displayStack + digit
                display!.text = textCurrentlyInDisplay + digit
                
            }
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
            //historyDisplay.text = String(newValue)
        }
    }
    
    
    
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        displayStack =  displayStack + sender.currentTitle!
        historyDisplay.text = displayStack
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            print(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            if sender.currentTitle != "="{
                    brain.performOperation("=")
                brain.performOperation(mathematicalSymbol)           }
            else{
                brain.performOperation(mathematicalSymbol)
            }
        }
        
        if let result = brain.result {
            if sender.currentTitle == "="{
                //                displayStack =  displayStack + String(result)
                //                historyDisplay.text = displayStack
                displayStack = ""
                displayStack =  displayStack + String(result)
                historyDisplay.text = String(result)
            }
            displayValue = result
        }
    }
}
