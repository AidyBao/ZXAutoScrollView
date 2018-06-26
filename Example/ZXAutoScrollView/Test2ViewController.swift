//
//  Test2ViewController.swift
//  ZXAutoScrollView_Example
//
//  Created by 120v on 2018/6/26.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
//import ZXPageControlView

class Test2ViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var zxAutoScrollView: ZXPageControlView!
    var testB:ZXPageControlView!
    var dataCount = 5
    var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.segmentControl.selectedSegmentIndex = 1
        for _ in 0..<10 {
            let r = CGFloat(arc4random() % 255) / 255.0
            let g = CGFloat(arc4random() % 255) / 255.0
            let b = CGFloat(arc4random() % 255) / 255.0
            colors.append(UIColor(red: r, green: g, blue: b, alpha: 1.0))
        }
        
        self.zxAutoScrollView.flipInterval = 3 // Default 2
        self.zxAutoScrollView.delegate = self
        self.zxAutoScrollView.dataSource = self
        
        self.testB = ZXPageControlView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        self.testB.delegate = self
        self.testB.dataSource = self
        self.testB.autoFlip = false //Default true, if pages less 1 false
        self.testB.backgroundColor = UIColor.gray
        self.testB.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: 120)
        self.view.addSubview(testB)
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dataCount = 1
        case 1:
            dataCount = 5
        case 2:
            dataCount = 10
        default:
            break
        }
        self.zxAutoScrollView.reloadData()
        self.testB.reloadData()
    }
    
}


extension Test2ViewController: ZXPageControlViewDataSource {
    func zxPageControlView(_ scrollView: ZXPageControlView, pageAt index: Int) -> UIView {
        let view = UILabel()
        var text = "PageA"
        
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 20)
        if scrollView == zxAutoScrollView {
            text = "PageB"
            view.backgroundColor = colors[index]
        } else {
            view.backgroundColor = colors[9 - index]
        }
        
        view.textColor = UIColor.white
        view.text = "\(text),Index:\(index + 1)"
        return view
    }
    
    
    func numberofPages(_ inScrollView: ZXPageControlView) -> Int {
        return dataCount
    }
}

extension Test2ViewController:ZXPageControlViewDelegate {
    func zxAutoScrolView(_ scrollView: ZXPageControlView, selectAt index: Int) {
        var text = "PageA"
        if scrollView == zxAutoScrollView {
            text = "PageB"
        }
        let alert = UIAlertController(title: "Tips", message: "\(text),Index:(\(index + 1))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


