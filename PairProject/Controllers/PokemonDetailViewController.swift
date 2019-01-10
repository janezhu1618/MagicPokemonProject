//
//  PokemonDetailViewController.swift
//  PairProject
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokemonCardImage: UIImageView!
    
    @IBOutlet weak var pokemonCardCollectionView: UICollectionView!
    @IBOutlet weak var pokemonCardImageActivityIndicator: UIActivityIndicatorView!
    
    var pokemon: PokemonCardsWrapper!
    var pokemonAttacks: [AttacksWrapper]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCardCollectionView.dataSource = self
        pokemonCardCollectionView.delegate = self
        pokemonCardImageActivityIndicator.startAnimating()
        ImageHelper.shared.fetchImage(urlString: pokemon.imageUrlHiRes) { (appError, image) in
            if let appError = appError {
                print(appError)
            } else if let image = image {
                self.pokemonCardImageActivityIndicator.stopAnimating()
                self.pokemonCardImage.image = image
            }
        }
        pokemonCardImageActivityIndicator.hidesWhenStopped = true
    }
    

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension PokemonDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.attacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonCardCollectionView.dequeueReusableCell(withReuseIdentifier: "PokemonDetailCell", for: indexPath) as? PokemonDetailCell else { return UICollectionViewCell() }
        let pokemonCardAttackToSet = pokemonAttacks[indexPath.row]
        cell.pokemonCardName.text = pokemonCardAttackToSet.name
        cell.pokemonCardDamage.text = pokemonCardAttackToSet.damage
        cell.pokemonCardDetail.text = pokemonCardAttackToSet.text
        return cell
    }
}

extension PokemonDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 275, height: 200)
    }
}
