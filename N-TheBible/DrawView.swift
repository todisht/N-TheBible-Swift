//
//  DrawView.swift
//  SwiftDrawing
//
//  Created by Tim Todish on 10/7/14.
//  Copyright (c) 2014 Tim Todish. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint?
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        lastPoint = touches.anyObject()?.locationInView(self)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var newPoint = touches.anyObject()?.locationInView(self)
        lines.append(Line(_start: lastPoint!, _end: newPoint!))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        
        CGContextSetRGBStrokeColor(context, 244.0/255.0, 138.0/255.0, 50.0/255.0, 1)
        CGContextSetLineCap(context, kCGLineCapRound )
        CGContextSetLineWidth(context, 18)
        CGContextStrokePath(context)
    
    }
    
}
