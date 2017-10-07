//
//  Graph.swift
//  Calculator
//
//  Created by Admin on 10/7/17.
//  Copyright © 2017 School. All rights reserved.
//

import UIKit
protocol GraphViewProtocol : class {
    func calculateY (sender: Graph, x: CGFloat)-> CGFloat?
    
}
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
    
    weak var functionGraph: GraphViewProtocol?
    
    private func getY (x: CGFloat, origin :CGPoint, pointPerUnit : CGFloat)-> CGFloat{
        let xx = (x - origin.x) / pointPerUnit
        let y = functionGraph? .calculateY(sender: self, x: xx)
        return (-((y! * pointPerUnit) - origin.y))
    }
    
    private func drawLine(input: CGRect, origin: CGPoint, pointPerUnit: CGFloat){
        let line = UIBezierPath()
        for drawX in stride(from: input.minX, to: input.maxX , by: 1){
            let drawY = self.getY(x : drawX, origin: origin, pointPerUnit: pointPerUnit)
            drawX == input.minX ? line.move(to: CGPoint(x: drawX, y: drawY)) : line.addLine(to: CGPoint(x: drawX, y: drawY))
        }
        line.stroke()
    }
    internal override func draw(_ rect: CGRect) {
        let axes = AxesDrawer()
        axes.drawAxes(in: rect, origin: centerPoint, pointsPerUnit: scaleFactor)
        self.drawLine(input: rect, origin: centerPoint, pointPerUnit: scaleFactor)
        
    }
    
}
