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
    
    let _shapeLayer = CAShapeLayer()
    var _radious = 0.0
    var _color = UIColor()
    var _sides = 3
    
    var _scale = 1.0
    var _rotation = 0.0
    
    enum PolygonOrientation {
        
        case Regular, Inverted
    }
    
    init(sides n: Int, radious r: Double, color c: UIColor) {
        
        _sides = n
        _radious = r
        _color = c
        
        var frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 2.0*r, height: 2.0*r))
        super.init(frame: frame)
        
        self.layer.mask = _shapeLayer // Masking the UIView so that you can see the polygon
        mask(bezierPath: polygonPath(sides: n, radious: r))
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tap:")))
        self.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: Selector("swipe:")))
        self.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: Selector("pinch:")))
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action:Selector("move:")))
        self.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action:Selector("rotate:")))
        
        self.userInteractionEnabled = true
        
        self.backgroundColor = _color
    }
    
    func polygonPath(sides n: Int, radious r: Double) -> UIBezierPath {
    
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
        
        return bp
       
    }
    
    func mask(bezierPath path: UIBezierPath) {
        
        _shapeLayer.path = path.CGPath
    }
    
    func tap(sender: UITapGestureRecognizer){
        
        mask(bezierPath: polygonPath(sides: ++_sides, radious: _radious))
    }
    
    func swipe(sender: UISwipeGestureRecognizer){
        
        _color = UIColor.randomColor()
        self.backgroundColor = _color
    }
    
    func pinch(sender: UIPinchGestureRecognizer){
        
        self.transform = transform(scale: sender.scale*_scale, angle: _rotation)
        
        if sender.state == .Ended {
            _scale *= sender.scale
        }
    }
    
    func move(sender: UILongPressGestureRecognizer){
        
        switch sender.state {
            
        case .Began:
            
            //So that user realizes it is moving it
            UIView.animateWithDuration(0.2){
                
                self.transform = self.transform(scale: self._scale*1.1, angle: self._rotation)
                self.alpha = 0.8
                self.center = sender.locationInView(self.superview)
                
                //Taking it to the top of the view
                self.superview.bringSubviewToFront(self)
            }
            
        case .Changed:
            
            //Move it
            self.center = sender.locationInView(self.superview)
            
        case .Ended, .Failed, .Cancelled:
            
            //Back to the original state
            UIView.animateWithDuration(0.2){
                
                self.transform = self.transform(scale: self._scale, angle: self._rotation)
                self.alpha = 1
            }
        default:
            break
        }
    }
    
    func rotate(sender: UIRotationGestureRecognizer){
        
        self.transform = transform(scale: self._scale, angle: self._rotation+sender.rotation)

        
        if sender.state == .Ended { _rotation += sender.rotation }
    }
    
    func transform(scale s: Double, angle a: Double) -> CGAffineTransform {
        
        //Apply both transforms at once
        return CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, s, s), CGAffineTransformRotate(CGAffineTransformIdentity, a))
    }
}

