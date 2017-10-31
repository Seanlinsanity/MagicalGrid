//
//  ViewController.swift
//  MagicalGrid
//
//  Created by SEAN on 2017/10/31.
//  Copyright © 2017年 SEAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numViewPerRow = 15
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for j in 0...30{
            for i in 0...numViewPerRow{
                let cellView = UIView()
            cellView.backgroundColor = randomColor()
            cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
            cellView.layer.borderWidth = 0.5
            cellView.layer.borderColor = UIColor.black.cgColor
            view.addSubview(cellView)
                
            let key = "\(i)|\(j)"
            cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
    }
    
    var isSeletedView : UIView?
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        let width = view.frame.width / CGFloat(numViewPerRow)
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        
        print(i,j)
        guard let currentSelectedView = cells["\(i)|\(j)"] else {
            return
        }
        
        if currentSelectedView != isSeletedView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.isSeletedView?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        isSeletedView = currentSelectedView
        
        view.bringSubview(toFront: currentSelectedView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            currentSelectedView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: nil)
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                currentSelectedView.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }

    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        //print("\(red), \(green), \(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

}

