//
//  PokemonViewController.swift
//  PairProject
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonCollection: UICollectionView!
    
    @IBOutlet weak var pokemonActivityIndicator: UIActivityIndicatorView!
    private var pokemonCards = [PokemonCardsWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.pokemonCollection.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCollection.dataSource = self
        pokemonCollection.delegate = self
        PokemonAPIClient.getPokemonCards { (appError, pokemon) in
            if let appError = appError {
                print(appError)
            } else if let pokemon = pokemon {
                self.pokemonCards = pokemon.cards
            }
        }
        
    }
    

}

extension PokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonCards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonCollection.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell else { return UICollectionViewCell() }
        cell.pokemonActivityIndicator.startAnimating()
        ImageHelper.shared.fetchImage(urlString: pokemonCards[indexPath.row].imageUrl) { (appError, image) in
            if let appError = appError {
                print(appError)
            } else if let image = image {
                cell.pokemonActivityIndicator.stopAnimating()
                cell.pokemonImage.image = image
            }
        }
        cell.pokemonActivityIndicator.hidesWhenStopped = true
        return cell
    }
}

extension PokemonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let pokemonDetailViewController = pokemonStoryboard.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController else { return }
        pokemonDetailViewController.modalPresentationStyle = .overCurrentContext
        pokemonDetailViewController.pokemon = pokemonCards[indexPath.row]
        pokemonDetailViewController.pokemonAttacks = pokemonCards[indexPath.row].attacks
        present(pokemonDetailViewController, animated: true, completion: nil)
    }
}
