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
    
    var centerPoint : CGPoint = CGPoint(x: 180, y: 300)
    var scaleFactor : CGFloat = 15
    
    weak var functionGraph: GraphViewProtocol?
    

    
    private func drawLine(input: CGRect, origin: CGPoint, pointPerUnit: CGFloat){
        
        let line = UIBezierPath()
        for drawX in stride(from: input.minX, to: input.maxX , by: 1){
            let y = functionGraph? .calculateY(sender: self, x: (drawX - origin.x) / pointPerUnit)
            let drawY = (-((y! * pointPerUnit) - origin.y))
           
            drawX == input.minX ? line.move(to: CGPoint(x: drawX, y: drawY)) : line.addLine(to: CGPoint(x: drawX, y: drawY))
        }
        line.stroke()
    }
    internal override func draw(_ rect: CGRect) {
        
        //AxesDrawer.switf used from an assigmnet materials from another school. link provited below. For my assigment did not require to draw  the axis.
        //https://itunesu-assets.itunes.apple.com/apple-assets-us-std-000001/CobaltPublic111/v4/d3/cc/f8/d3ccf813-811f-0a8a-0f97-a3da51065fcb/305-7790343223312375480-CS193P_Winter_17_Assignment_3.pdf
        let axes = AxesDrawer()
        axes.drawAxes(in: rect, origin: centerPoint, pointsPerUnit: scaleFactor)
        self.drawLine(input: rect, origin: centerPoint, pointPerUnit: scaleFactor)
        
    }
    
}
