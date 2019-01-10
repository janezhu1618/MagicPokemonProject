//
//  MagicCell.swift
//  PairProject
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class MagicCell: UICollectionViewCell {
    @IBOutlet weak var magicImage: UIImageView!
    
    @IBOutlet weak var magicActivity: UIActivityIndicatorView!
    
    
    public func configureCell(magic: CardsWrapper) {
        
       
        
        magicActivity.startAnimating()
        
        ImageHelper.shared.fetchImage(urlString: magic.imageUrl ?? "No image found") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                self.magicActivity.stopAnimating()
                self.magicImage.image = image
                
            }
        }
        self.magicActivity.hidesWhenStopped = true
    }
    
}
