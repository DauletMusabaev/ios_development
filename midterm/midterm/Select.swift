//
//  Select.swift
//  midterm
//
//  Created by Daulet Mussabayev on 3/7/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//


import UIKit

class Select: UIViewController {
    
    var onSelect: ((UIColor) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func colorSelected(_ sender: UIButton) {
        if sender.titleLabel?.text == "RED" {
            self.onSelect?(UIColor.red)
        } else {
            self.onSelect?(UIColor.blue)
        }
        
        self.dismiss(animated: true)
    }
}
