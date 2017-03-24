//
//  ViewController.swift
//  FBLiveStreamAnimation
//
//  Created by Stepan Paholyk on 3/24/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    /*
        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .gray
        view.addSubview(curvedView)
    */
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
    fileprivate func generateAnimatedViews() {
        
        let randImage = drand48() < 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: randImage)
        
        let dimension = 20 + drand48() *  9
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = getConfiguredAnimation()
        imageView.layer.add(animation, forKey: nil)
        
        view.addSubview(imageView)
    }

}

func getConfiguredAnimation() -> CAAnimation {
    let animation = CAKeyframeAnimation(keyPath: "position")
    
    animation.path = customPath().cgPath
    animation.duration = 2 + drand48() * 2
    
    print(animation.duration)
    
    animation.fillMode = kCAFillModeForwards
    animation.isRemovedOnCompletion = false
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

    return animation
}

func customPath() -> UIBezierPath {
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    
    let endPoint = CGPoint(x: 400, y: 200)
    
    let yShift = 200 + drand48() * 250
    
    let cp1 = CGPoint(x: 100, y: 100 + yShift)
    let cp2 = CGPoint(x: 200, y: 300 - yShift)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    
    return path
    
}

class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {

        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
    
}

