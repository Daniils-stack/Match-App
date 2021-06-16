//
//  ViewController.swift
//  Match App
//
//  Created by Daniil Reshetnyak on 6/17/20.
//  Copyright © 2020 Daniil Reshetnyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    
    var millisecond:Float = 30 * 1000//10 seconds
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
  
        cardArray = model.getCard()
    
    //Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timereElapsed), userInfo: nil, repeats: true)

        RunLoop.main.add(timer!, forMode: .common)
    }
    
    
    //Mark: - Timer Methods
    
    
    
    @objc func timereElapsed() {
        
        millisecond -= 1
        
        //Convert to seconds
        
        let seconds = String(format: "%.2f", millisecond/1000)
        
        //Set label
        
        timeLabel.text = "Time elapsed: \(seconds)"
        
        
        //When milliseconds reached 0
        
        if millisecond <= 0 {
            
            //Stop the timer
            timer?.invalidate()
            timeLabel.textColor = UIColor.red
            
            //Check if there are any unmatched cards
            
            checkGameEnded()
        }
    }
    // Mark: - Protocol methods implementation
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //Get an CardCollectionViewCell object
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CardCell", for: indexPath)
            as! CardCollectionViewCell
        
        //Get the card that collection view is trying to display
        let card = cardArray[indexPath.row]
        
        //Set the card for the cell
        cell.setCard(card: card)
        return cell
        
        
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if millisecond <= 0 {
            
            return
            
        }
        
        //Get the cell that user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            //flip the card
            cell.flip()
            //set the status of the card
            card.isFlipped = true
            
            // Determine what card was flipped
            
            if firstFlippedCardIndex == nil {
                //This is first card being flipped
                firstFlippedCardIndex = indexPath
            }
            else {
              
                checkForMatches(indexPath)
                 //This is second card being flipped
                //TODO: perform the matcing logic
                
                
            }
        }
        else {
            // flip the card back
            cell.flipBack()
            //set the status of the card
            card.isFlipped = false
        }
        
       
        
    }//End of didSelectItem
    
    
    
    
    
    
    
    
    

    
    //Marl: Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        // Get the cells for two cards that were reveal
        
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the cards for two cards that were reveal
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        
        //Compare two cards
        
        if cardOne.imageName == cardTwo.imageName {
        
            // it's a match
            
        
            // Set the status of the cards
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove cards from the grid
            
            cardOneCell?.removeCell()
            cardTwoCell?.removeCell()
            
            
            //Check if there are any card left unmatched
            
            checkGameEnded()
        }
        else {
        
            // It's not a match
            
            // Set the status of the card
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both card back
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            
        }
        
        //Tell the collection view reload cell of the first card if it is nil
        
        
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        firstFlippedCardIndex = nil
            
    }
    
    
   

    func checkGameEnded() {
    
        //Determine if there are any card unmatched
        
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                
                isWon = false
                break
                
            }
            
        }
        
        
        //Messiging varibels
        
        var title = ""
        var messaging = ""
        
    
        
        //If not, then user has won, stop the timer
        
        if isWon == true {
            
            if millisecond > 0 {
        
                timer?.invalidate()
                
                title = "Congratulation"
                messaging = "You have won"
                
            }
    
        }
        
        else {
            
            if millisecond > 0 {
        
                return
                
            }
            
            title = "Game over"
            messaging = "You've lost"
            
        }
        
        //Show won/lost messaging
        
        showAlert(title: title, message: messaging)
      
    
    }
    
    
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    
        
        
    }
    
}//End ViewCintroller class




