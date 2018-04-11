//
//  PullView.swift
//  PullViewSwift
//
//  Created by travelsky on 2018/4/11.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

import Foundation
import UIKit

func DX(p1:CGPoint,p2:CGPoint) -> Float {
    return Float(p2.x - p1.x);
};

func DY(p1:CGPoint,p2:CGPoint) -> Float {
    return Float(p2.y - p1.y);
};

let kSwipeDragMin:Float = 16;
let kDragLimitMax:Float = 12;

enum SwipeTyps: Int{
    case TouchUnknown = 1
    case TouchSwipeLeft
    case TouchSwipeRight
    case TouchSwipeUp
    case TouchSwipeDown
};

class PullView: UIView,UIGestureRecognizerDelegate {
    var dragView:DragView = DragView.init(frame: CGRect.zero);
    var gestureWasHandled:Bool = false;
    var pointCount:Int = 0;
    var startPoint:CGPoint = CGPoint.zero;
    var touchType:SwipeTyps = SwipeTyps.TouchUnknown;
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        self.isUserInteractionEnabled = true;
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(PullView.handlePan(gesture:)));
        pan.delegate = self;
        self.addGestureRecognizer(pan);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true;
    }
    
    
    @objc func handlePan(gesture:UIPanGestureRecognizer){
        if(!(self.superview is UIScrollView))
        {
            return;
        }
        let supersuper = self.superview?.superview;
        let scroll = self.superview as! UIScrollView;
        
        let touchLocation:CGPoint = gesture.location(in: superview);
        if(gesture.state ==  UIGestureRecognizerState.began)
        {
            gestureWasHandled = false;
            pointCount = 1;
            startPoint = touchLocation;
        }
        if(gesture.state == UIGestureRecognizerState.changed)
        {
            pointCount += 1;
            
            let dx = DX(p1: touchLocation, p2: startPoint);
            let dy = DY(p1: touchLocation, p2: startPoint);
            
            var finished:Bool = true;
            
            if ((dx > kSwipeDragMin) && (abs(dy) < kDragLimitMax)){
                touchType = SwipeTyps.TouchSwipeLeft;
            }// hswipe left
            else if ((-dx > kSwipeDragMin) && (abs(dy) < kDragLimitMax)){
                touchType = SwipeTyps.TouchSwipeRight;
            } // hswipe right
            else if ((dy > kSwipeDragMin) && (abs(dx) < kDragLimitMax)) {
                touchType = SwipeTyps.TouchSwipeUp;
            }// vswipe up
            else if ((-dy > kSwipeDragMin) && (abs(dx) < kDragLimitMax)){
                touchType = SwipeTyps.TouchSwipeDown;
            } // vswipe down
            else{
                finished = false;
            }
            if (!gestureWasHandled && finished && (touchType == SwipeTyps.TouchSwipeDown))
            {
                dragView = DragView.init(frame: self.frame);
                dragView.center = touchLocation;
                dragView.backgroundColor = self.backgroundColor;
                supersuper?.addSubview(dragView);
                scroll.isScrollEnabled = false;
                gestureWasHandled = true;
            }
            else if(gestureWasHandled)
            {
                dragView.center = touchLocation;
            }
        }
        if gesture.state == UIGestureRecognizerState.ended {
            scroll.isScrollEnabled = true;
        }
        
    }
    
}






