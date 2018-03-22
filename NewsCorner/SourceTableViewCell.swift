//
//  SourceTableViewCell.swift
//  NewsCorner
//
//  Created by Shivam Dev on 15/03/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit
import SDWebImage


class SourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var sourceDescription: UILabel!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Data Model
    
    func updateUI(name: String, description: String, title: String, imageName: String) {
        
        sourceName.text = name
        sourceDescription.text = description
        titleName.text = title
        
        if imageName.isEmpty {
            if let url = URL(string: "http://leeford.in/wp-content/uploads/2017/09/image-not-found.jpg") {
                newsImage.sd_setImage(with: url, completed: nil)
            }
        } else {
            if let url = URL(string: imageName) {
                newsImage.sd_setImage(with: url, completed: nil)
            }
        }
        
        
        
        
    }
    
}

