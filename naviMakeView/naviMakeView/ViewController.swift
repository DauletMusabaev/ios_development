//
//  ViewController.swift
//  naviMakeView
//
//  Created by Daulet Mussabayev on 2/29/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(presentView))
    }
    
    @objc func presentView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "parametresView") as newViewController
        
        vc.onSelect = { [weak self] width, height, x, y, color in
            guard let self = self else {return}
            
            let newView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTap))
            newView.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.viewDidPan(recognizer:)))
            newView.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.viewDidPinch))
            newView.addGestureRecognizer(pinchGestureRecognizer)
            
            newView.backgroundColor = color
            self.view.addSubview(newView)
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func viewDidTap(_ sender: UITapGestureRecognizer) {
        if let newView = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "parametresView") as newViewController
            vc.selected = newView
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    var baseOrigin: CGPoint!
    @objc func viewDidPan(recognizer: UIPanGestureRecognizer) {
        if let newView = recognizer.view {
            switch recognizer.state {
            case .began:
                baseOrigin = newView.frame.origin
            case .changed:
                let d = recognizer.translation(in: newView)
                newView.frame.origin.x = baseOrigin.x + d.x
                newView.frame.origin.y = baseOrigin.y + d.y
            default: break
            }
        }
    }
    
    @objc func viewDidPinch(_ sender: UIPinchGestureRecognizer) {
        if let newView = sender.view {
            if sender.state == .began || sender.state == .changed {
                newView.transform = (newView.transform.scaledBy(x: sender.scale, y: sender.scale))
               sender.scale = 1.0
            }
        }
    }
    
    
}

