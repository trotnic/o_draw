//
//  CoolView.swift
//  Drawings
//
//  Created by Vladislav on 6/7/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

import UIKit


//@IBDesignable
class CoolView: UIView {

    private var lines: [[CGPoint]] = [[CGPoint]]()
    var color: UIColor = .black
    
    func beganDraw(_ touch: UITouch) {
        let firstPoint = touch.location(in: self)
        lines.append([CGPoint]())
        lines[lines.count - 1].append(firstPoint)
    }
    
    
    func movedBrush(_ touch: UITouch) {
        let currentPoint = touch.location(in: self)
        lines[lines.count - 1].append(currentPoint)
        setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        draw(inContext: ctx)
    }
    
    
    func draw(inContext context: CGContext) {
        context.setLineWidth(4)
//        context.setStrokeColor(self.color.cgColor)
        context.setLineCap(.round)
        
        
        for line in lines {
            
            guard let firstPoint = line.first else { return }
            let path = CGMutablePath()
            path.move(to: firstPoint)
//            context.beginPath()
//            context.move(to: firstPoint)
            
            for point in line.dropFirst() {
                path.addLine(to: point)
            }
            
            context.beginPath()
            context.addPath(path)
            color.setStroke()
            context.strokePath()
        }
    }
}
