//
//  DragView.swift
//  PullViewSwift
//
//  Created by travelsky on 2018/4/11.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

import Foundation
import UIKit

class DragView: UIView {
    var originalCenter: CGPoint;
    
    override init(frame: CGRect) {
        self.originalCenter = CGPoint.zero;
        super.init(frame: frame);
        self.isUserInteractionEnabled = true;
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(DragView.panAction(gesture:)));
        self.addGestureRecognizer(pan);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self);
        originalCenter = self.center;
    }
    
    @objc func panAction(gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: self.superview);
        self.center = CGPoint.init(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y);
        
    }
}


