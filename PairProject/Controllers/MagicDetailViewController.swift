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
        detailCollectionView.dataSource = self
        
        
     }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   

}

extension MagicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicDetial.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicDetailCell", for: indexPath) as? MagicDetailCell else {
            fatalError("MagicDetailCell error")
        }

        let magidDetail = magicDetial[indexPath.row]
        detailCell.configureDetailCell(magicDetail: magidDetail)
        
        
        return detailCell
    }
    
    
}


