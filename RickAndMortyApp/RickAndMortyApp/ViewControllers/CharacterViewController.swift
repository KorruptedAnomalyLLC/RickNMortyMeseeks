//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Austin West on 5/15/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateViews(character: Character, image: UIImage) {
        DispatchQueue.main.async {
            self.nameLabel.text = character.name
            self.spriteImageView.image = image
            self.speciesLabel.text = character.species
            self.statusLabel.text = character.status
            
        }
    }
    
    // 1: Button tapped
    // 2: Find a random number
    // 3: append this number to the url
    // 4: Make network request
    @IBAction func buttonTapped(_ sender: Any) {
        //        print("ljkh")
        let randomNumber = "\(Int.random(in: 0...493))"
        CharacterController.sharedInstance.fetchCharacter(searchTerm: randomNumber) { (character) in
            guard let character = character else { return }
            CharacterController.sharedInstance.fetchImageFor(character: character, completion: { (image)
                in
                guard let image = image else { return }
                //                    update the views
                self.updateViews(character: character, image: image)
            })
        }
    }
    
}




