//
//  ItemController.swift
//  iOSGameWS2017
//
//  Created by PRITHVI RAJ on 03/02/2018.
//  Copyright © 2018 PRITHVI RAJ. All rights reserved.
//

import SpriteKit

class ItemController {
	let minX = CGFloat(-300)
	let maxX = CGFloat(350)
	
	// Generate Item function which returns Item as SKSpriteNode
	func generateItem(scene: SKScene) -> SKSpriteNode {
		// Declare an Item variable of type SKSpriteNode
		let item: SKSpriteNode?
		
		// Generate a Random Number between >=0 and <10
		if Int(generateRandomNumber(firstNum: 0, secondNum: 10)) >= 6 {
			// Assign item Bomb
			item = SKSpriteNode(imageNamed: "Bomb")
			
			// Set item name to Bomb
			item?.name = "Bomb"
			
			// Set item scale to 0.1
			item?.setScale(0.1)
			
			// Set item body to circle with radius of half the item height
			item?.physicsBody = SKPhysicsBody(circleOfRadius: (item?.size.height)!/2);
		} else {
			// generate another random number between >=1 and <3
			let num = Int(generateRandomNumber(firstNum: 1, secondNum: 3))
			
			// if num is equal to 1 then generate a Euro 1 coin else Euro 2 coin
			if num == 1 {
				// Assign item Euro 1 coin
				item = SKSpriteNode(imageNamed: "Euro 1")
				// Set item name to Coin
				item?.name = "Coin"
				// Set item scale to 0.1
				item?.setScale(0.1)
				// Set item body to circle with radius of half the item height
				item?.physicsBody = SKPhysicsBody(circleOfRadius: (item?.size.height)!/2)
			} else {
				// Assign item Euro 2 coin
				item = SKSpriteNode(imageNamed: "Euro 2")
				// Set item name to Coin2
				item?.name = "Coin2"
				// Set item scale to 0.1
				item?.setScale(0.1)
				// Set item body to circle with radius of half the item height
				item?.physicsBody = SKPhysicsBody(circleOfRadius: (item?.size.height)!/2)
			}
		}
		// Set item's categoryBitMask to 3 (Coin_AND_Bomb) from the BodyType ENUM
		item?.physicsBody?.categoryBitMask = BodyType.Coin_AND_Bomb.rawValue
		
		// Set item's zPosition
		item?.zPosition = 3
		
		// Set item's anchor point
		item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		
		// Set item's random position on x-axis
		item?.position.x = generateRandomNumber(firstNum: minX, secondNum: maxX)
		
		// Set item's y position to that of frame height + 60 so that it is added out of frame on top
		item?.position.y = scene.frame.size.height + 60
		
		return item!
	}
	
	// Function to generate random numbers between two given numbers and returns it as CGFloat
	// The arc4random() function returns pseudo-random numbers in the range of 0 to (2**32)-1
	// UInt32_Max = Maximum Unsigned 32 Bit Integer Value
	// Abs is function to find out absolute number
	// Min is function to find out Minimum number of the two
	func generateRandomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
		return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum)
		+ min(firstNum, secondNum)
	}
}

