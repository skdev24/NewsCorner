//
//  NameCollectionViewCell.swift
//  NewsCorner
//
//  Created by Shivam Dev on 16/03/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class NameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
            nameCell.layer.cornerRadius = 5
            nameCell.layer.borderWidth = 0.5
            nameCell.layer.borderColor = UIColor.green.cgColor


        nameCell.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        
    }
    
    func UIUpdate(name: String) {
        nameCell.setTitle(name, for: .normal)
    }
    

}
