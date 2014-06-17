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
    var _physicsEnabled = false
    var _collisions: UICollisionBehavior?
    var _gravity: UIGravityBehavior?
    
    let _initialRadious = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hola"
        _drawingView.backgroundColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor.redColor()
        
        var tapRecog = UITapGestureRecognizer(target: self, action: Selector("createShape:"))
        _drawingView.userInteractionEnabled = true
        _drawingView.addGestureRecognizer(tapRecog)
        self.view.userInteractionEnabled = true
        
        setupPhysics()
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
        
        let p = PolygonView(sides: 3, radious: _initialRadious, color: UIColor.randomColor())
        p.frame.origin = CGPoint(x: _point.x-_initialRadious, y: _point.y-_initialRadious) //Calculate origin so the touch is the center of the polygon
        
        _drawingView.addSubview(p)
        _polygons += p
        
        updatePhysics()
        phy()
        
        p.transformClosure = {
            self._animator!.updateItemUsingCurrentState(p)
        }
    }
    
    func setupPhysics() {
        
         self._animator = UIDynamicAnimator(referenceView: _drawingView)
        
         _collisions = UICollisionBehavior(items: _polygons)
         _collisions!.translatesReferenceBoundsIntoBoundary = true
        
         _gravity = UIGravityBehavior(items: _polygons)
         _gravity!.gravityDirection = CGVectorMake(0,1)

    }
    
    func updatePhysics() {
        
        _collisions = UICollisionBehavior(items: _polygons)
        _collisions!.translatesReferenceBoundsIntoBoundary = true
        _gravity = UIGravityBehavior(items: _polygons)
    }
    
    func phy() {
        
        if _physicsEnabled {
            
            _animator!.addBehavior(_collisions!)
            _animator!.addBehavior(_gravity!)
        } else {
            _animator!.removeAllBehaviors()
        }

    }
    @IBAction func physics(sender: UIButton) {
        
        phy()
        sender.setTitle("Physics \(String(!_physicsEnabled))", forState: .Normal)
        _physicsEnabled = !_physicsEnabled
        
    }
    
}

