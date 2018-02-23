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
	case Coin_AND_Bomb = 3
	case somethingElse = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	// Declaring variables
	var thePlayer: SKSpriteNode = SKSpriteNode()
	var infoLabel: SKLabelNode?
	var scoreLabel: SKLabelNode?
	var score: Int = 0
    var backGroundSound :SKAudioNode = SKAudioNode()
	var ySpeed: Int = -2
	
	// SpriteKit Sound Actions
	let bigCoinSound = SKAction.playSoundFileNamed("bigCoin.mp3", waitForCompletion: false)
    let smallCoinSound = SKAction.playSoundFileNamed("smallCoin.wav", waitForCompletion: false)
    let bombSound = SKAction.playSoundFileNamed("bomb.mp3", waitForCompletion: false)
    
	// Load Item Controller
	let itemController = ItemController()
	
	/* --------- LEARNING - IGNORE ---------
	// Gestures -- implemented while learning
	let swipeRightRec = UISwipeGestureRecognizer()
	let swipeLeftRec = UISwipeGestureRecognizer()
	let swipeTopRec = UISwipeGestureRecognizer()
	let swipeBottomRec = UISwipeGestureRecognizer()
	let rotateRec = UIRotationGestureRecognizer()
	*/
	
	// didMove(to view: SKView) is called immediately after a scene is presented by a view.
    override func didMove(to view: SKView) {
		// Set the anchor point
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		// Set this view to phyicsworld contact delegate to detect contacts/collisions
		self.physicsWorld.contactDelegate = self
		
		// Assign the center of frame value to center variable
		// center = self.frame.size.width / self.frame.size.height
		
		// Create the background
		createGrounds()
		
		// Check if player exists and initializae the player's properties
		if let player: SKSpriteNode = self.childNode(withName: "player") as? SKSpriteNode {
			thePlayer = player
			
			// Player cannot be moved by other objects
			thePlayer.physicsBody?.isDynamic = false
			
			// Player is not affected by Gravity
			thePlayer.physicsBody?.affectedByGravity = false
			
			/* The categoryBitMask property is a number defining the type of object this is for considering collisions. */
			// Set Player's categoryBitMask to 1 (player) from the BodyType ENUM
			thePlayer.physicsBody?.categoryBitMask = BodyType.player.rawValue
			
			/* The collisionBitMask property is a number defining what categories of object this node should collide with. */
			// Set Player's collisionBitMask to 3 (Coin_AND_Bomb) from the BodyType ENUM
			thePlayer.physicsBody?.collisionBitMask = BodyType.Coin_AND_Bomb.rawValue
			
			/* The contactTestBitMask property is a number defining which collisions we want to be notified about. */
			// Set Player's contactTestBitMask to 3 (Coin_AND_Bomb) from the BodyType ENUM
			thePlayer.physicsBody?.contactTestBitMask = BodyType.Coin_AND_Bomb.rawValue
			
			//print("that worked")
		} else {
			//print("that did not work")
		}
		
		// Assign the infoLabel variable infoLabel SKLabelNode
		infoLabel = self.childNode(withName: "infoLabel") as? SKLabelNode
		
		// Clear the Info Label
		infoLabel?.text = ""
		
		// Assign the scoreLabel variable scoreLabel SKLabelNode
		scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
		
		// Set the Score Label text to zero
		scoreLabel?.text = "0"
        
        //Saving sound URL and Adding it to background as music using SKAudioNode
        if let musicURL = Bundle.main.url(forResource:"backMusic", withExtension: "mp3")  {
            backGroundSound = SKAudioNode(url:musicURL)
            addChild(backGroundSound)
        }
		
		// Run a timer every 1 or 2 seconds and call the function generateItems()
		Timer.scheduledTimer(timeInterval: TimeInterval (itemController.generateRandomNumber(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameScene.generateItems), userInfo: nil, repeats: true)
		
		// Run a timer every 5 seconds and call the increaseSpeed() function
		Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameScene.increaseSpeed), userInfo: nil, repeats: true)
		
		// Run a timer every 5.5 seconds and call the updateInfoLabel() function
		Timer.scheduledTimer(timeInterval: 5.5, target: self, selector: #selector(GameScene.updateInfoLabel), userInfo: nil, repeats: true)
		
		// Schedule the timer for every 8 seconds to call removeItem function for deleting uncollected nodes
		Timer.scheduledTimer(timeInterval: TimeInterval(8), target: self, selector: #selector(GameScene.removeItem), userInfo: nil, repeats: true)
		
		/*------------------- LEARNING STUFF --------------------------
		// Learning Rotations and Swipe Gestures
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

		
		// Assigning CategoryBitMask to Building Sprite on the Scene
		for possibleBuilding in self.children {
			if (possibleBuilding.name == "Building" || possibleBuilding.name == "Buildingx") {
				if (possibleBuilding is SKSpriteNode) {
					possibleBuilding.physicsBody?.categoryBitMask = BodyType.building.rawValue
					print("Found a \(String(describing: possibleBuilding.name))!")
				}
			}
		}
		*/
    }
	
	// Called before each frame is rendered
	override func update(_ currentTime: TimeInterval) {
		// Move the background on every frame update
		moveGrounds()
		// cleanUp()
	}
	
	// Create the background
	func createGrounds() {
		// For loop using range 0-3
		for i in 0...3 {
			// Create background node with image `ground2-stars`
			let ground = SKSpriteNode(imageNamed: "ground2-stars")
			
			// Set background name
			ground.name = "Ground"
			
			// Set background zPosition
			ground.zPosition = -1
			
			// Set background size
			ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
			
			// Set background anchor point
			ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
			
			// Set background position
			//print("i: \(i) & y: \( CGFloat(i) * ground.size.height )")
			ground.position = CGPoint(x: 0, y: CGFloat(i) * ground.size.height)
			
			// Add the background node to scene
			self.addChild(ground)
		}
	}
	
	// Move the ground by moving it along y-axis
	func moveGrounds() {
		// enumerateChildNodes searches for a given node and returns callback of `node` and `error` in this case.
		// `node` can be worked with for setting it's position or zposition etc.
		self.enumerateChildNodes(withName: "Ground") { (node, error) in
			// Move it along y-axis with a decrement of -2 in position.y
			node.position.y -= 2
			
			// Check if position of the background is way off to the bottom of the screen
			if (node.position.y < -(self.scene?.size.height)!) {
				// Now Move the node along y-axis with an increment of scene height times the ground was created i.e. 3
				node.position.y += (self.scene?.size.height)! * 3
			}
		}
	}
	
	// Generate randomly a Coin or Bomb
	@objc func generateItems() {
		self.scene?.addChild(itemController.generateItem(scene: self.scene!))
	}
	
	//MARK: Physics Contacts
	func didBegin(_ contact: SKPhysicsContact) {
		var firstBody = SKPhysicsBody()
		var secondBody = SKPhysicsBody()
		
		// Assign the contact bodies to respective variables
		// makes sure that firstBody is always `player`!
		if contact.bodyA.node?.name == "player" {
			// Assign bodyA to firstBody
			firstBody = contact.bodyA
			
			// Assign bodyB to secondBody
			secondBody = contact.bodyB
		} else {
			// Assign bodyB to firstBody
			firstBody = contact.bodyB
			
			// Assign bodyA to secondBody
			secondBody = contact.bodyA
		}
		
		// Check if second body is Coin -- point!!
		if firstBody.node?.name == "player" && secondBody.node?.name == "Coin" {
			// Update the score
			score += 1
			
			// Update the score label
			scoreLabel?.text = String(score)
			
			// Remove coin from scene
			secondBody.node?.removeFromParent()
			
			//Euro 1 Sound
			run(smallCoinSound)
		}
		
		// Check if second body is Coin 2 -- point!!
		if firstBody.node?.name == "player" && secondBody.node?.name == "Coin2" {
			// Update the score
			score += 2
			
			// Update the score label
			scoreLabel?.text = String(score)
			
			// Remove coin from scene
			secondBody.node?.removeFromParent()
			
			//2 Euro Sound
			run(bigCoinSound)
		}
		
		// Check if second body is Bomb -- game over case!
		if firstBody.node?.name == "player" && secondBody.node?.name == "Bomb" {
            
			// Remove first body from scene
			firstBody.node?.removeFromParent()
			
			// Remove second body from scene
			secondBody.node?.removeFromParent()
			
			// Update the info label
			infoLabel?.text = "Game Over!"
			
			// Bomb Sound
			run(bombSound)
            
            // Show explosion animation
            let explosion = SKEmitterNode(fileNamed: "explosion")!
            
            explosion.position = thePlayer.position
            
            self.addChild(explosion)
            
            self.run(SKAction.wait(forDuration: 2)){
                explosion.removeFromParent()
            }
			
			// Stoping Background Music
			backGroundSound.run(SKAction.stop())
			
			// Set the timer to excute restartGame() function after 2 seconds
			Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameScene.restartGame), userInfo: nil, repeats: false)
		}
		
		/*
		if (contact.bodyA.categoryBitMask == BodyType.player.rawValue
		&& contact.bodyB.categoryBitMask == BodyType.building.rawValue) {
		print("touched a buildingx")
		} else if (contact.bodyB.categoryBitMask == BodyType.player.rawValue
		&& contact.bodyA.categoryBitMask == BodyType.building.rawValue) {
		print("touched a buildingy")
		}
		*/
	}
	
	// Remove uncollected Coins and Bombs to optimize performance
	@objc func removeItem() {
		// Nodes as `children` - inherited from SKScene
		for child in children {
			// Check if child's name is either coin or bomb or coin2
			if child.name == "Coin" || child.name == "Bomb" || child.name == "Coin2" {
				// check if child's position is out of the bounds on y-axis in negative and remove it
				if child.position.y < -(self.scene?.frame.height)! - 100 {
					// remove the child if it has already passed down to bottom of the screen and out of frame
					child.removeFromParent()
				}
			}
		}
	}
	
	@objc func increaseSpeed() {
		infoLabel?.text = "Level Up!"
		self.physicsWorld.gravity = CGVector(dx: 0, dy: self.ySpeed)
		self.ySpeed = self.ySpeed - 3
	}
	
	@objc func updateInfoLabel(){
		infoLabel?.text = ""
	}
	
	// Restart the game if the player is hit by a Bomb!
	@objc func restartGame() {
		// Load the SKScene from 'GameScene.sks'
		if let scene = SKScene(fileNamed: "GameScene") {
			// Set the scene scale mode to scale to fit the window
			scene.scaleMode = .aspectFill
			
			// set the scene physics world gravity to 0 on x-axis and -2 on y-axis
			scene.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
			
			// Present the scene with a SKTransition having time interal of 2
			self.view?.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
		}
	}
	
	// Move down function
	func moveDown(pos : CGPoint) {
		// define the action to be performed
		let action: SKAction = SKAction.move(to: pos, duration: 0.5)
		
		// perform the action on the player
		thePlayer.run(action)
	}
	
	// Move up function
	func moveUp(pos: CGPoint) {
		// define the action to be performed
		let action: SKAction = SKAction.move(to: pos, duration: 0.5)
		
		// perform the action on the player
		thePlayer.run(action)
	}
	
	// Detect touch down and its position
    func touchDown(atPoint pos : CGPoint) {
//		print("Touched at x: \(pos.x)")
//		print("Touched at y: \(pos.y)")
		
		// Check where was the touch down detected
		if pos.y > 0 {
			// top half touch
			moveUp(pos: pos)
		} else {
			// bottom half touch
			moveDown(pos: pos)
		}
    }
    
    func touchMoved(toPoint pos : CGPoint) { }
    
    func touchUp(atPoint pos : CGPoint) { }
	
	// Touches functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches { self.touchDown(atPoint: t.location(in: self)); break }
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
	
	/*
	//MARK: Gesture Recognizer Functions
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
	}*/
}
