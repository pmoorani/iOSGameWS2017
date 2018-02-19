//
//  GameMenu.swift
//  iOSGameWS2017
//
//  Created by PRITHVI RAJ on 09/02/2018.
//  Copyright © 2018 PRITHVI RAJ. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameMenu: SKScene {
	//Creating variables for Game Menu
	var playGameButtonNode: SKSpriteNode!
	var quitButtonNode : SKSpriteNode!
	
	override func didMove(to view: SKView) {
		playGameButtonNode = self.childNode(withName: "playGameButton") as! SKSpriteNode
		quitButtonNode = self.childNode(withName: "quitButton") as! SKSpriteNode
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		let touch = touches.first
		if let location = touch?.location(in: self){
			let nodesArray = self.nodes(at: location)
			if nodesArray.first?.name == "playGameButton" {
				let gameScene = GameScene(fileNamed: "GameScene")!
				let transition = SKTransition.flipHorizontal(withDuration: 1)
				gameScene.scaleMode = .aspectFill
				gameScene.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
				self.view?.presentScene(gameScene, transition: transition)
			} else if nodesArray.first?.name == "quitButton" {
				quit()
			}
			
		}
		
		
	}
	
	func quit() {
		exit(0)
	}

}
