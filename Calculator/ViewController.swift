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
    
    @IBAction func M(_ sender: UIButton) {
        
        memory = memory + Double(display.text!)!
        display!.text = String(memory)
    }
    
    @IBAction func clear(_ sender: Any) {
        display.text = "0"
    }
    
    @IBAction func clearStack(_ sender: Any) {
        display.text = "0"
        historyDisplay.text = ""
        brain.clearStack()
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        
        historyDisplay.text = historyDisplay.text! + digit
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            //If display has so
            if digit == "0" && display.text == "0" {
                return
            }
            if digit  != "." || textCurrentlyInDisplay.range(of:".") == nil {
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
                brain.performOperation("=")
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
