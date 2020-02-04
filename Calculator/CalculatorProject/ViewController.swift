//
//  ViewController.swift
//  CalculatorProject
//
//  Created by Mussabayev Daulet on 2/4/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = Calculator()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

     var clearLabelAfterClick = true
       @IBAction func numberPressed(_ sender: UIButton) {
           guard
               let lblText = sender.titleLabel?.text
           else { return }
           
        
           if clearLabelAfterClick {
               let firstNum = resultLabel.text!
               //if resultLabel.text != "0" {
                   resultLabel.text = firstNum + lblText
               
           } else {
               resultLabel.text = lblText
               clearLabelAfterClick = true
           }
           
       }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let lblText = resultLabel.text,
            let number = Double(lblText),
            let operation = sender.titleLabel?.text
        else {
            return
        }
        
        //resultLabel.text = ""
        model.setOperand(number: number)
        model.executeOperation(symbol: operation)
        resultLabel.text = "\(model.result)"
        clearLabelAfterClick = false

        
    }
}

