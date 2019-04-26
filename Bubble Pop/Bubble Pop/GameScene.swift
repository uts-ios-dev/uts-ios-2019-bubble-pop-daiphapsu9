//
//  GameScene.swift
//  Bubble Pop
//
//  Created by Quang Binh Dang on 24/4/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        setupView()
        setupAction()
    }
    
    // Setup view
    func setupView() {
        self.backgroundColor = UIColor.white
        removeAllChildren()
        GameEngine.shared.reset()
    }
    
    func setupAction() {
        let generateAction = SKAction.run({ [weak self] in
            self!.generateBubble()
        })
        self.run(SKAction.repeatForever(SKAction.sequence([generateAction, SKAction.wait(forDuration: 0.5)])))
        
        let updateTimeAction = SKAction.run({ [weak self] in
            self!.updateTime()
        })
        self.run(SKAction.repeatForever(SKAction.sequence([updateTimeAction, SKAction.wait(forDuration: 1)])))
    }
    
    // helper
    func generateBubble() {
        let type = randomType()
        let bubble = BubbleNode(type : type)
        bubble.size = CGSize(width: 50.0, height: 50.0)
        bubble.position = CGPoint(x: Int.random(in: Int(bubble.size.width/2)..<Int((self.view?.bounds.width)!-bubble.size.width/2)), y: 0)
        
        addChild(bubble)
        bubble.float(toY: (self.view?.bounds.height)!)
    }
    
    
    func randomType() -> BubbleType {
        let randomNumber = Int.random(in: 0 ..< 100)
        if (randomNumber < 5) {
            return .Black
        } else if (randomNumber < 15) {
            return .Blue
        } else if (randomNumber < 30) {
            return .Green
        } else if (randomNumber < 60) {
            return .Pink
        } else {
            return .Red
        }
    }
    
    func updateTime() {
        GameEngine.shared.duration -= 1
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: TIME_UPDATE_NOTIF), object: nil)
        if(GameEngine.shared.duration == 0) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GAME_OVER_NOTIF), object: nil)
        }
    }
    
}