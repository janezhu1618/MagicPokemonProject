//
//  MagicDetailCell.swift
//  PairProject
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class MagicDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var magicPicture: UIImageView!
    
    @IBOutlet weak var cardName: UILabel!
    
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var magicText: UITextView!
    
    @IBOutlet weak var detailActivity: UIActivityIndicatorView!
    
    
    public func configureDetailCell(magicDetail: ForeignNamesrapper) {
        
        
        
        detailActivity.startAnimating()
        
        ImageHelper.shared.fetchImage(urlString: magicDetail.imageUrl) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                
                self.magicPicture.image = image
                
            }
        }
        self.detailActivity.stopAnimating()
    }
}
