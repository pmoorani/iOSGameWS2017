//
//  GameScene.swift
//  iOSGameWS2017
//
//  Created by PRITHVI RAJ on 16/01/2018.
//  Copyright © 2018 PRITHVI RAJ. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	var thePlayer: SKSpriteNode = SKSpriteNode()
	
    override func didMove(to view: SKView) {
		
//		self.anchorPoint = CGPoint(x: 0.5, y: 0)
		
		if let player: SKSpriteNode = self.childNode(withName: "player") as? SKSpriteNode {
			thePlayer = player
			thePlayer.physicsBody?.isDynamic = false
			
			print("that worked")
			
		} else {
			print("that did not work")
		}
		
    }
	
	override func update(_ currentTime: TimeInterval) {
		// Called before each frame is rendered
		
//		if thePlayer.position.y > 0  {
//			print("greater")
//		} else {
//			print("less than 0")
//		}
	}
	
	func moveDown(pos : CGPoint) {
//		let moveDownAction: SKAction = SKAction.moveBy(x: pos.x, y: pos.y, duration: 1)
		let action: SKAction = SKAction.move(to: pos, duration: 1)
		thePlayer.run(action)
		
	}
	
	func moveUp(pos: CGPoint) {
//		let moveUpAction: SKAction = SKAction.moveBy(x: pos.x, y: pos.y, duration: 1)
		let action: SKAction = SKAction.move(to: pos, duration: 1)
		thePlayer.run(action)
	}
    
    func touchDown(atPoint pos : CGPoint) {
		print("Touched at x: \(pos.x)")
		print("Touched at y: \(pos.y)")
		
		if pos.y > 0 {
			// top half touch
			moveUp(pos: pos)
			
		} else {
			// bottom half touch
			moveDown(pos: pos)
		}
		
    }
    
    func touchMoved(toPoint pos : CGPoint) {
		
    }
    
    func touchUp(atPoint pos : CGPoint) {
		
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
			self.touchDown(atPoint: t.location(in: self))
			break
		}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
	
}
