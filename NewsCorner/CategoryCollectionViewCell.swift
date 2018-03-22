//
//  CategoryCollectionViewCell.swift
//  NewsCorner
//
//  Created by Shivam Dev on 16/03/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate {
    
    
    @IBOutlet weak var categoryCell: UIButton!
    
    
    var btnNunber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryCell.layer.cornerRadius = 5
        categoryCell.layer.borderWidth = 1
        categoryCell.layer.borderColor = UIColor.green.cgColor
        //        nameCell.addBorder(toSide: .Right, withColor: UIColor.green.cgColor, andThickness: 1)
        
        //        myButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        
        categoryCell.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
    }
    
    
    func UIUpdate(name: String) {
        categoryCell.setTitle(name, for: .normal)
        
    }
    
    
    
    
    
    
}




