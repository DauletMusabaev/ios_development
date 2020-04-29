//
//  MusicPlayerVC.swift
//  MusicFileManager
//
//  Created by Daulet Mussabayev on 4/30/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import UIKit

class MusicPlayerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    @IBAction func play(_ sender: UIButton) {
        MusicService.shared.play_pause()

    }
    
    @IBAction func pause(_ sender: UIButton) {
        MusicService.shared.pause()
    }
}
