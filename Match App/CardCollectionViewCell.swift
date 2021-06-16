//
//  CardCollectionViewCell.swift
//  Match App
//
//  Created by Daniil Reshetnyak on 6/17/20.
//  Copyright © 2020 Daniil Reshetnyak. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(card:Card) {
        
        if card.isMatched == true {
            
            //If card was been matched, then make the image view invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
            
        }
        else {
            //If card hasn't been matched, then make the image view visible 
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        //keep track of the card that gets passed in
        
        self.card = card
        frontImageView.image = UIImage(named:card.imageName)
        
        //Determine if the card is in a flipped up state or flipped down state
        
        if card .isFlipped == true {

            //Make sure that the front image view on the display
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)


        }
        else {

            //Make sure that the back image view on the display
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)

        }
    }
    
    func flip() {
    
    UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
    
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
            
        }
    }
    
    func removeCell() {
        
        //Remove both imageViews
        //TODO: animate it
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
        backImageView.alpha = 0
       
        
    }
}
