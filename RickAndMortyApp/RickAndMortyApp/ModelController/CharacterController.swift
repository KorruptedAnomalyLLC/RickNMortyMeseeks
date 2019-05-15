//
//  CharacterController.swift
//  RickAndMortyApp
//
//  Created by Austin West on 5/15/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class CharacterController {
    
//    singleton
    static let sharedInstance = CharacterController()
    
//    CRUD
//    Search by ID or Character's name
    func fetchCharacter(searchTerm: String, completion: @escaping (Character?) -> Void) {
        
//        build the URL
        guard let baseUrl = URL(string: "https://rickandmortyapi.com/api/") else { return }
//        Add components and query items
        let characterComponentURL = baseUrl.appendingPathComponent("character")
//        https://rickandmortyapi.com/api/character/
        let finalURL = characterComponentURL.appendingPathComponent(searchTerm)
//        https://rickandmortyapi.com/api/character/'searchTerm'
        
//        test the URL
        print(finalURL)
        
//        Start dataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
//            chefk if there is an error
            if let error = error {
                print("There was an error with the portal gun when retrieving \(searchTerm): \(error)")
                return
            }
            
//            check if there is data
            if let data = data {
//                decode the data
                do {
                    let character = try JSONDecoder().decode(Character.self, from: data)
                    completion(character)
                } catch {
                    print("Error teleporting the character...")
                    completion(nil);return
                }
            }
        }.resume()
    }
    
    func fetchImageFor(character: Character, completion: @escaping (UIImage?) -> Void) {
        let baseURL = character.image
        
        let dataTask = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            completion(image)
        }
        dataTask.resume()
    }
}
