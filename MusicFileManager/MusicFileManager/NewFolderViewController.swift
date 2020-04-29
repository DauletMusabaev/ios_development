//
//  NewFolderViewController.swift
//  MusicFileManager
//
//  Created by Daulet Mussabayev on 4/30/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import UIKit

class NewFolderViewController: UIViewController {

    @IBOutlet weak var createFolderButton: UIButton!
    @IBOutlet weak var newTitle: UITextField!
    
    var currentPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ok = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(createFolder(_:)))
        navigationItem.rightBarButtonItems = [ok]
        
    }
    
    
    @IBAction func createFolder(_ sender: UIButton) {
        guard let newtitle = newTitle.text else {
            return
        }
        guard let curPath = currentPath else { return}
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        var docURL = URL(string: documentsDirectory)!
        docURL = docURL.appendingPathComponent(curPath)
        let dataPath = docURL.appendingPathComponent(newtitle)

        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
                navigationController?.popViewController(animated: true)


            } catch {
                print(error.localizedDescription);
            }
        }

    }
    
}
