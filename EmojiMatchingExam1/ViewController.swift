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
    
    
    @IBAction func pressedNewGame(_ sender: Any) {
        newGame()
    }
    
    @IBAction func pressedGameButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newGame() {
        
    }


}

