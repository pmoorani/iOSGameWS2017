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
	
	func generateItem(scene: SKScene) -> SKSpriteNode {
		let item: SKSpriteNode?
		
		if Int(generateRandomNumber(firstNum: 0, secondNum: 10)) >= 6 {
			item = SKSpriteNode(imageNamed: "Bomb")
			item?.name = "Bomb"
			item?.setScale(0.1)
			item?.physicsBody = SKPhysicsBody(circleOfRadius: (item?.size.height)!/2);
		} else {
//			let num = Int(generateRandomNumber(firstNum: 0, secondNum: 3))
			item = SKSpriteNode(imageNamed: "Euro 1")
			item?.name = "Coin"
			item?.setScale(0.1)
			item?.physicsBody = SKPhysicsBody(circleOfRadius: (item?.size.height)!/2)
		}
		
		item?.physicsBody?.categoryBitMask = BodyType.Coin_AND_Bomb.rawValue
		item?.zPosition = 3
		item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		item?.position.x = generateRandomNumber(firstNum: minX, secondNum: maxX)
		
		item?.position.y = scene.frame.size.height + 60
//		item?.position.y = 500

		
		return item!
	}
	
	func generateRandomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
		return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum)
		+ min(firstNum, secondNum)
	}
}

