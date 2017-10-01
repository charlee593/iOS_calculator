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
    
    
    
    var userIsInTheMiddleOfTyping = false
    var memory : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyDisplay.text = ""
    }
    
    @IBAction func MC(_ sender: UIButton) {
        memory = 0
    }
    
    @IBAction func MR(_ sender: UIButton) {
        display!.text = String(memory)
        userIsInTheMiddleOfTyping = true
        historyDisplay!.text = historyDisplay!.text! + String(memory)
    }
    
    @IBAction func MS(_ sender: UIButton) {
        memory = Double(display.text!)!
    }
    
    //M+ button
    @IBAction func M(_ sender: UIButton) {
        
        memory = memory + Double(display.text!)!
        display!.text = String(memory)
    }
    
    @IBAction func clear(_ sender: Any) {
        display.text = "0"
    }
    
    @IBAction func Undo(_ sender: UIButton) {
        if display.text?.count == 1 {
            
        }
        else {
            
            display.text =  String(display.text!.characters.dropLast())
            
        }
    }
    
    
    
    
    //clear stack
    @IBAction func clearStack(_ sender: Any) {
        display.text = "0"
        historyDisplay.text = ""
        brain.clearStack()
    }
    @IBAction func resultVariableName(_ sender: UIButton) {
        if let val = brain.variableValues["->"+sender.currentTitle!]{
            
            display.text = String(val)
        }
        else {
            brain.setOperand(variableName: "->"+sender.currentTitle!)
            display.text = "0"
            
        }
        brain.setOperand(displayValue)
        historyDisplay.text = historyDisplay.text! + sender.currentTitle!
    }
    
    @IBAction func setVariableValue(_ sender: UIButton) {
        if brain.variableValues[sender.currentTitle!] != nil{
            brain.variableValues[sender.currentTitle!] = Double(display.text!)
        }
        else {
                brain.setOperand(variableName: "->"+sender.currentTitle!)
                brain.variableValues[sender.currentTitle!] = Double(display.text!)
        }
        
        
        
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            //If display has zero and user type zero do nothing
            if digit == "0" && display.text == "0" {
                return
            }
            else if Double(textCurrentlyInDisplay) == 0{
                display!.text = digit
                historyDisplay.text = historyDisplay.text! + digit
            }
            else if digit  != "." || textCurrentlyInDisplay.range(of:".") == nil {
                display!.text = textCurrentlyInDisplay + digit
                historyDisplay.text = historyDisplay.text! + digit
            }
        }
        else {
            display.text = digit
            historyDisplay.text = historyDisplay.text! + digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        historyDisplay.text = historyDisplay.text! + sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            if sender.currentTitle != "="{
                brain.performOperation("=") //compute the result in history before the next operation
                brain.performOperation(mathematicalSymbol)
            }
            else{
                brain.performOperation(mathematicalSymbol)
            }
        }
        
        if let result = brain.result {
            if sender.currentTitle == "="{
                historyDisplay.text = String(result)
            }
            displayValue = result
        }
    }
}
