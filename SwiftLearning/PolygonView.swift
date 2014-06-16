//
//  ShapeView.swift
//  SwiftLearning
//
//  Created by Jorge Izquierdo on 15/06/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit
import QuartzCore

class PolygonView: UIView {
    
    enum PolygonOrientation {
        
        case Regular, Inverted
    }
    
    init(sides n: Int, radious r: Double) {
        
        var frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 2.0*r, height: 2.0*r))
        super.init(frame: frame)
        
        self.drawPolygon(sides: n, radious: r)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap"))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tapRecognizer)
        self.userInteractionEnabled = true
        
    }
    
    func drawPolygon(sides n: Int, radious r: Double){
    
        var points: CGPoint[] = CGPoint[](count: n, repeatedValue:CGPoint())
        points[0] = CGPoint(x: r, y:0)
        
        var calculations: Int = 0 //Number of points we have to find each side of the diameter
        
        if n % 2 == 0 {
            
            //If number of sides is even, place the one that is one diameter away
            points[Int(n / 2)] = CGPoint(x: r, y: 2*r)
            calculations = (n/2)-1
        }
        else {
            
            calculations = (n-1)/2
        }
        
        for i in 1...calculations{
            
            //Math stuff
            var lenght = 2.0*r*sin(Double(i)*M_PI/Double(n))
            var angle = M_PI/2 - (Double(i)*M_PI/Double(n))
            
            var x = lenght*sin(angle)
            var y = lenght*cos(angle)
            
            points[i] = CGPoint(x: r-x, y: y)
            points[n-i] = CGPoint(x: r+x, y: y)
            
        }
        
        var bp = UIBezierPath()
        
        bp.moveToPoint(points[0])
        for i in 0..points.count{
            bp.addLineToPoint(points[i])
        }
        bp.closePath()
        
        var shape = CAShapeLayer(layer: self.layer)
        shape.path = bp.CGPath
        self.layer.mask = shape
        
        
    }
    
    func tap(sender: UITapGestureRecognizer){
        
        println("You just tapped a shape")
    }
}

