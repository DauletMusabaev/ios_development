//
//  FolderCollectionViewCell.swift
//  MusicFileManager
//
//  Created by Daulet Mussabayev on 4/30/20.
//  Copyright © 2020 Daulet Mussabayev. All rights reserved.
//

import UIKit

class FolderCollectionViewCell: UICollectionViewCell {
    
    var title: String? {
        didSet{
             guard let title = title else { return }
            titleFolder.text = title
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleFolder: UILabel!
}
