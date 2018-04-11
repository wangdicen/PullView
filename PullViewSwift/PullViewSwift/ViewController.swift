//
//  ViewController.swift
//  PullViewSwift
//
//  Created by travelsky on 2018/4/10.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 60, width: self.view.frame.size.width, height: 50));
        scrollView.isScrollEnabled = true;
        scrollView.backgroundColor = UIColor.red;
        scrollView.contentSize = CGSize.init(width: 50*10, height: 50);
        self.view.addSubview(scrollView);
        for i in 0..<9{
            let  pullview = PullView.init(frame: CGRect.init(x: 50*i, y: 0, width: 50, height: 50));
            pullview.backgroundColor = UIColor.init().randomColor();
            scrollView.addSubview(pullview);

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


