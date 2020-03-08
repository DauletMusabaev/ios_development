//
//  newViewController.swift
//  naviMakeView
//
//  Created by Daulet Mussabayev on 3/5/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import Foundation
import UIKit

class newViewController: UIViewController {
    
    var color: UIColor?
    var selected: UIView?
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    
    @IBOutlet weak var colorButtons: UIButton!
    
    var onSelect: ((_ width: Int, _ height: Int, _ x: Int, _ y: Int, _ color: UIColor) -> Void)? = nil
    
    
    @IBAction func colorSelect(_ sender: UIButton) {
        
        guard let backgColor = sender.backgroundColor else {return}
        color = backgColor
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveView))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteView))
        guard selected != nil else {
             navigationItem.rightBarButtonItems = [ saveButton ]
            return
        }
        navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard selected != nil else {return}
        print(selected?.frame.width as Any)
        self.widthTextField.text = selected?.frame.width.description
        self.heightTextField.text = selected?.frame.height.description
        self.xTextField.text = selected?.frame.origin.x.description
        self.yTextField.text = selected?.frame.origin.y.description
    }
    
    @objc func saveView() {
        
        guard let width = widthTextField.text, let height = heightTextField.text, let x = xTextField.text, let y = yTextField.text, let color = color else {
            let alert = UIAlertController(title: "Error", message: "Fill all data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let widthDouble = Double(width), let heightDouble = Double(height), let xDouble = Double(x), let yDouble = Double(y) else {
            let alert = UIAlertController(title: "Error", message: "Not correct data type", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let screenSize = UIScreen.main.bounds
        
        if CGFloat(widthDouble) > screenSize.width || CGFloat(heightDouble) > screenSize.height {
            let alert = UIAlertController(title: "Error", message: "Data is bigger than view", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard let newView = selected else {
            onSelect?(Int(widthDouble), Int(heightDouble), Int(xDouble), Int(yDouble), color)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        newView.backgroundColor = color
        newView.frame = CGRect(x: CGFloat(xDouble), y: CGFloat(yDouble), width: CGFloat(widthDouble), height: CGFloat(heightDouble))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteView() {
        guard let newView = selected else {return}
        newView.removeFromSuperview()
        
        self.navigationController?.popViewController(animated: true)
    }
}
