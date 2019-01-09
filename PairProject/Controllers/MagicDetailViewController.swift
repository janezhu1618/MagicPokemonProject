//
//  MagicDetailViewController.swift
//  PairProject
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class MagicDetailViewController: UIViewController {
    
    var magicDetial = [ForeignNamesrapper]()
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
     }
    

   

}

extension MagicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicDetailCell", for: indexPath) as? MagicDetailCell else {
            fatalError("MagicDetailCell error")
        }
//        detailCell.cardName.text = magicDetial.name
//        detailCell.language.text = 
        let image = magicDetial[indexPath.row].imageUrl
        //detailCell.configureDetailCell(magicDetail: image)
        
        
        return detailCell
    }
    
    
}


