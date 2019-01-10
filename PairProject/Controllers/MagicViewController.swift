//
//  ViewController.swift
//  PairProject
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {
    var magic = [CardsWrapper](){
        didSet{
            DispatchQueue.main.async {
                self.magicCollectionView.reloadData()
            }
        }
    }
    @IBOutlet weak var magicCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        magicCollectionView.dataSource = self
        magicCollectionView.delegate = self
        uploadData()
        
        
    }
    private func uploadData() {
        MagicAPIClient.getMagicCards { (appError, magic) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let magic = magic {
                self.magic = magic.cards.filter{ $0.imageUrl != nil }
            
            }
        }
    }
}

extension MagicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicCell", for: indexPath) as? MagicCell else {
            fatalError("MagicCell error")
        }
        let image = magic[indexPath.row]
        cell.configureCell(magic: image)
        
    return cell
    }
    
}

extension MagicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 130, height: 200)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storybord = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "MagicDetail") as? MagicDetailViewController else { return }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.magicDetial = magic[indexPath.row].foreignNames
        
        
      
        present(vc,animated: true, completion: nil)
    }
    
}
