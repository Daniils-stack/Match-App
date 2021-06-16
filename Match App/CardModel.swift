//
//  CardModel.swift
//  Match App
//
//  Created by Daniil Reshetnyak on 6/17/20.
//  Copyright © 2020 Daniil Reshetnyak. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCard() -> [Card] {
        
        //Declare the array to store the generated cards
        var generatedCardArray = [Card]()
        
        
        for _ in 1...8 {
            //Get a randow number
            let randomNumber = arc4random_uniform(13)+1
            
            // print number
            print(randomNumber)
            //Create the first card object
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            generatedCardArray.append(cardOne)
            
            //Create the second card object
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            
            generatedCardArray.append(cardTwo)
            
            //OPTIONAL: Make it we so only have unique pairs of cards
            
        }
      
         //Return the array
        
        return generatedCardArray
        
    }
    
}
