//
//  GameScene.swift
//  iOSGameWS2017
//
//  Created by PRITHVI RAJ on 16/01/2018.
//  Copyright © 2018 PRITHVI RAJ. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyType: UInt32 {
	
	case player = 1
	case building = 2
	case somethingElse = 4
	
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var thePlayer: SKSpriteNode = SKSpriteNode()
	var moveSpeed: TimeInterval = 1
	let swipeRightRec = UISwipeGestureRecognizer()
	let swipeLeftRec = UISwipeGestureRecognizer()
	let swipeTopRec = UISwipeGestureRecognizer()
	let swipeBottomRec = UISwipeGestureRecognizer()
	let rotateRec = UIRotationGestureRecognizer()
	
    override func didMove(to view: SKView) {
		
//		self.anchorPoint = CGPoint(x: 0.5, y: 0)
		
		self.physicsWorld.contactDelegate = self
		
		rotateRec.addTarget(self, action: #selector (GameScene.rotatedView(_:) ))
		self.view?.addGestureRecognizer(rotateRec)
		
		swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight))
		swipeRightRec.direction = .right
		self.view?.addGestureRecognizer(swipeRightRec)
		
		swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft))
		swipeLeftRec.direction = .left
		self.view?.addGestureRecognizer(swipeLeftRec)
		
		swipeTopRec.addTarget(self, action: #selector(GameScene.swipedTop))
		swipeTopRec.direction = .up
		self.view?.addGestureRecognizer(swipeTopRec)
		
		swipeBottomRec.addTarget(self, action: #selector(GameScene.swipedBottom))
		swipeBottomRec.direction = .down
		self.view?.addGestureRecognizer(swipeBottomRec)
		
		if let player: SKSpriteNode = self.childNode(withName: "player") as? SKSpriteNode {
			thePlayer = player
			thePlayer.physicsBody?.isDynamic = false
			thePlayer.physicsBody?.affectedByGravity = false
			thePlayer.physicsBody?.categoryBitMask = BodyType.player.rawValue
			thePlayer.physicsBody?.collisionBitMask = BodyType.building.rawValue | BodyType.somethingElse.rawValue
			thePlayer.physicsBody?.contactTestBitMask = BodyType.building.rawValue | BodyType.somethingElse.rawValue
			
			print("that worked")
			
		} else {
			print("that did not work")
		}
		
		// Assigning CategoryBitMask to Building Sprite on the Scene
		for possibleBuilding in self.children {
			if (possibleBuilding.name == "Building" || possibleBuilding.name == "Buildingx") {
				if (possibleBuilding is SKSpriteNode) {
					possibleBuilding.physicsBody?.categoryBitMask = BodyType.building.rawValue
					print("Found a \(possibleBuilding.name)!")
				}
			}
		}
		
    }
	
	// Gesture Recognizers
	@objc func rotatedView(_ sender: UIRotationGestureRecognizer) {
		if (sender.state == .began) {
			print("Rotation began")
		}
		
		if (sender.state == .changed) {
			print("Rotation changed")
			//print(sender.rotation)
			
			let rotateAmount = Measurement(value: Double(sender.rotation), unit: UnitAngle.radians).converted(to: .degrees).value
			print(rotateAmount)
			
			thePlayer.zRotation = -sender.rotation
		}
		
		if (sender.state == .ended) {
			print("Rotation ended")
		}
	}
	
	@objc func swipedRight() {
		print("Swiped Right")
	}
	
	@objc func swipedLeft() {
		print("Swiped Left")
	}
	
	@objc func swipedTop() {
		print("Swiped Top")
	}
	
	@objc func swipedBottom() {
		print("Swiped Bottom")
	}
	
	// Clean Gestures when switching to different scene class
	func cleanUp() {
		for gesture in (self.view?.gestureRecognizers)! {
			self.view?.removeGestureRecognizer(gesture)
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		// cleanUp()
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
	
	//MARK: Physics Contacts
	func didBegin(_ contact: SKPhysicsContact) {
		if (contact.bodyA.categoryBitMask == BodyType.player.rawValue
			&& contact.bodyB.categoryBitMask == BodyType.building.rawValue) {
			print("touched a buildingx")
		} else if (contact.bodyB.categoryBitMask == BodyType.player.rawValue
			&& contact.bodyA.categoryBitMask == BodyType.building.rawValue) {
			print("touched a buildingy")
		}
	}
    
    
	
}
