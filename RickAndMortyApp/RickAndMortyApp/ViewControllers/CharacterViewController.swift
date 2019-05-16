//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Austin West on 5/15/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var gifImage: UIImageView!
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayerTwo: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifImage.loadGif(name: "Portal")
        
        guard let path = Bundle.main.path(forResource: "Rick-and-Morty-Theme-Song", ofType: "mp3")
            else { return }
        let url = URL(fileURLWithPath: path)
        audioPlayer = try? AVAudioPlayer(contentsOf: url, fileTypeHint:  nil)
        audioPlayer?.prepareToPlay()
        audioPlayer?.setVolume(0.3, fadeDuration: 0.1)
        audioPlayer?.play()
        audioPlayer?.numberOfLoops = -1
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
        guard let pathTwo = Bundle.main.path(forResource: "pickle_rick", ofType: "mp3")
            else { return }
        let urlTwo = URL(fileURLWithPath: pathTwo)
        self.audioPlayerTwo = try? AVAudioPlayer(contentsOf: urlTwo, fileTypeHint:  nil)
        self.audioPlayerTwo?.prepareToPlay()
        self.audioPlayerTwo?.setVolume(0.8, fadeDuration: 0.1)
        self.audioPlayerTwo?.play()
        
        let randomNumber = "\(Int.random(in: 0...493))"
        CharacterController.sharedInstance.fetchCharacter(searchTerm: randomNumber) { (character) in
            guard let character = character else { return }
            CharacterController.sharedInstance.fetchImageFor(character: character, completion: { (image)
                in
                guard let image = image else { return }
                //                    update the views
                self.updateViews(character: character, image: image)
            }
            )
        }
    }
    
    @IBAction func buttonTappedTwo(_ sender: UIButton) {
        sender.buttonAnimation()
    }
}




