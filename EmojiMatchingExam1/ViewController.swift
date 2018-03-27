//
//  ViewController.swift
//  EmojiMatchingExam1
//
//  Created by CSSE Department on 3/25/18.
//  Copyright © 2018 Rose-Hulman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gameButtons: [UIButton]!
    var game = MatchingGame(numPairs: 10);
    var blockingIntentionally = false
    
    @IBAction func pressedNewGame(_ sender: Any) {
        newGame()
    }
    
    @IBAction func pressedGameButton(_ sender: Any) {
        if blockingIntentionally{
            return;
        }
        let gameBoardButton = sender as! UIButton
        let index = gameBoardButton.tag
        game.pressedCard(atIndex: index)
        updateCard(index)
        if (game.gameState == .complete) {
            blockingIntentionally = true
            delay(1.2){
                //not the most elegant solution, but it works
                self.game.startNewTurn()
                self.updateAllButtons()
                self.blockingIntentionally = false
            }
        }
    
        //updateCard(index)
    }
    
    func updateAllButtons() {
        var font: UIFont
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact){
            font = UIFont(name: (gameButtons[0].titleLabel?.font.fontName)!, size: 64)!
        } else {
            font = UIFont(name: (gameButtons[0].titleLabel?.font.fontName)!, size: 100)!
        }
        
        for i in 0..<20 {
            gameButtons[i].titleLabel?.font = font
            updateCard(i)
        }
    }
    
    func updateCard(_ index: Int) {
        let button = gameButtons[index]
        switch(game.cardStates[index]) {
            case .hidden:
                button.setTitle(String(game.cardBack), for: UIControlState.normal)
            case .shown:
                button.setTitle(String(game.cards[index]), for: UIControlState.normal)
            case .removed:
                button.setTitle("", for: UIControlState.normal)
        }
    }
    
    func newGame() {
        game = MatchingGame(numPairs: 10)
        print(game.description)
        updateAllButtons()
        blockingIntentionally = false;
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
}


