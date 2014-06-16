//
//  ViewController.swift
//  SwiftLearning
//
//  Created by Jorge Izquierdo on 15/06/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var _drawingView: UIView
    var _scrollView = UIScrollView()
    var _polygons = UIView[]()
    var _animator: UIDynamicAnimator?
    let initialRadious = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hola"
        _drawingView.backgroundColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor.redColor()
        
        var tapRecog = UITapGestureRecognizer(target: self, action: Selector("createShape:"))
        _drawingView.userInteractionEnabled = true
        _drawingView.addGestureRecognizer(tapRecog)
        self.view.userInteractionEnabled = true
        
        //scrollView = UIScrollView(frame: self.view.bounds)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createShape(sender: UITapGestureRecognizer){
        
        drawPolygon(point: sender.locationInView(_drawingView))
    }
    
    func drawPolygon(point _point: CGPoint) {
        
        let p = PolygonView(sides: 3, radious: initialRadious, color: UIColor.randomColor())
        p.frame.origin = CGPoint(x: _point.x-initialRadious, y: _point.y-initialRadious) //Calculate origin so the touch is the center of the polygon

        _drawingView.addSubview(p)
        _polygons += p
    }
    
    @IBAction func enableGravity() {
        
        self._animator = UIDynamicAnimator(referenceView: _drawingView)
        var viewsArray = _polygons
        viewsArray += _drawingView
        _animator!.addBehavior(UICollisionBehavior(items: viewsArray))
        
        var gravity: UIGravityBehavior = UIGravityBehavior(items: _polygons)
        gravity.gravityDirection = CGVectorMake(0,-1)
        _animator!.addBehavior(gravity)
    
    }
    
}

