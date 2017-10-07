//
//  Graph.swift
//  Calculator
//
//  Created by Admin on 10/7/17.
//  Copyright © 2017 School. All rights reserved.
//

import UIKit

class Graph: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var centerPoint : CGPoint = CGPoint(x: 200, y: 200)
    var scaleFactor : CGFloat = 50
    
    internal override func draw(_ rect: CGRect) {
        let axes = AxesDrawer()
        axes.drawAxes(in: rect, origin: centerPoint, pointsPerUnit: scaleFactor)
    }
}
