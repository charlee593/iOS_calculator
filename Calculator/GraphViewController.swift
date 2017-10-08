//
//  GraphViewController.swift
//  Calculator
//
//  Created by Admin on 10/7/17.
//  Copyright © 2017 School. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController , GraphViewProtocol{
    internal func calculateY(sender: Graph, x: CGFloat) -> CGFloat? {
        
        
        
if operatorGraph ==  "sin" || operatorGraph == "cos" || operatorGraph == "tan"{
    
    brain.accumulator = Double(x)
 brain.performOperation(operatorGraph!)
    brain.performOperation("=")
    
        }
else{
    //print (acumulatorGraph)
        brain.performOperation("=")
      brain.accumulator = acumulatorGraph

        }
        return CGFloat(brain.result!)
    }
    
    var history : [Dictionary<String,String>]?
    var acumulatorGraph : Double = 0
    var operatorGraph : String?
    var valueX : Double = 0
   // valueX = Double(history.last)
    private var brain = CalculatorBrain()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var VariableGraphView: Graph!{
        didSet{
            VariableGraphView.functionGraph = self
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
