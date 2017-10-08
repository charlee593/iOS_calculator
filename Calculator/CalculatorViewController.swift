//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 School. All rights reserved.
//

import UIKit


class CalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!
    var justPop = false
    
    
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
        if display.text?.count == 1 || justPop {
            
            let dic = brain.stackPop()
            if (dic["history"] != nil) {
                historyDisplay.text = dic["history"]
                display.text = dic["display"]
            
                justPop = true
            }
            else {
                historyDisplay.text = ""
                display.text = "0"
            }
        }
        else {
            historyDisplay.text =  String(historyDisplay.text!.characters.dropLast())
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
        justPop = false
        
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
        brain.stackPush(historyDisplay: historyDisplay.text!, display: display.text!)
        justPop = true
        if sender.currentTitle ==  "sin" || sender.currentTitle == "cos" || sender.currentTitle == "tan"{
            historyDisplay.text =  sender.currentTitle! + "("+historyDisplay.text!+")"
        }
        else{
            historyDisplay.text = historyDisplay.text! + sender.currentTitle!
        }
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        var mathsymbol : String?
        if let mathematicalSymbol = sender.currentTitle {
            
            if sender.currentTitle != "="{
                brain.performOperation("=") //compute the result in history before the next operation
                brain.performOperation(mathematicalSymbol)
            }
            else{
                brain.performOperation(mathematicalSymbol)
                mathsymbol = mathematicalSymbol
            }
            
        }
        
        if let result = brain.result {
            if sender.currentTitle == "="{
                historyDisplay.text = String(result)
            }
            displayValue = result
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination
        if let navagationController = destination as? UINavigationController{
            destination = navagationController.visibleViewController ?? destination
        }
        if segue.identifier == "Graph Segue" {
            if let graphViewController = destination as? GraphViewController{
                graphViewController.history = brain.historyStackAndValue
                //print(brain.variableValues)
                graphViewController.acumulatorGraph = brain.accumulator ?? 0
                //graphViewController.operatorGraph = mathSymbol
                
            }
        }
    }
}
