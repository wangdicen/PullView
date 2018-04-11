//
//  UIColor+Random.swift
//  PullViewSwift
//
//  Created by travelsky on 2018/4/11.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    func randomColor() -> UIColor{
        let red = CGFloat(arc4random()%255);
        let green = CGFloat(arc4random()%255);
        let blue = CGFloat(arc4random()%255);
        
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0);
    }
}
