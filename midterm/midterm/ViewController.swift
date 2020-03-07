//
//  ViewController.swift
//  midterm
//
//  Created by Daulet Mussabayev on 3/7/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import UIKit


protocol ViewControllerDelegate: class {
    func changeBackgroundColor(_ color: UIColor?)
}



class ViewController: UIViewController {

    weak var delegate: ViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func selecColor(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "select") as? Select
        else { return }
        
        selectVC.onSelect = { color in
            
            
            sender.backgroundColor = color
        }
        
        delegate?.changeBackgroundColor(sender.backgroundColor)
        self.present(selectVC, animated: true)
    }

}

