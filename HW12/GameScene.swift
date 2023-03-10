//
//  GameScene.swift
//  HW12
//
//  Created by Gizem Melisa Ates on 4/22/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameOver: SKLabelNode!
    var missesLeft: SKLabelNode!
    var score: SKLabelNode!
    var yourScore: SKLabelNode!
    var start: SKLabelNode!
    
    var bagSprite = SKSpriteNode(imageNamed: "bags.png")
    
    var foods = ["pizza", "spaghetti", "tacos", "salad", "icecreams"]
    
    var missesNum: Int! = 0
    var scoreNum: Int! = 0
    
    var isRunning = false
    
    var timer = Timer()

    
    override func didMove(to view: SKView) {
        // Set screen edge
        let screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = screenPhysicsBody
        self.name = "Wall"
        self.physicsWorld.contactDelegate = self
        
        start = self.childNode(withName: "Start") as? SKLabelNode
        gameOver = self.childNode(withName: "GameOver") as? SKLabelNode
        missesLeft = self.childNode(withName: "MissesLeft") as? SKLabelNode
        score = self.childNode(withName: "Score") as? SKLabelNode
        yourScore = self.childNode(withName: "YourScore") as? SKLabelNode
        
        initial()
       
        self.bagSprite = SKSpriteNode(imageNamed: "bags.png")
        bagSprite.name = "bag"
        bagSprite.physicsBody = SKPhysicsBody(rectangleOf: bagSprite.frame.size)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: update)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            if isRunning{
                let point = touch.location(in: self)
                let nodeArray = nodes(at: point)
                for node in nodeArray {
                    print("tapped \(node.name!)")
                    if (node.name == "bag"){
                        bagSprite.position.x = (point.x)
                    }
                }
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if isRunning{
                let point = touch.location(in: self)
                let nodeArray = nodes(at: point)
                for node in nodeArray {
                    //print("moved \(node.name!)")
                    if (node.name == "bag"){
                        bagSprite.position.x = (point.x)
                    }
                }
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if isRunning != true{
                let point = touch.location(in: self)
                let nodeArray = nodes(at: point)
                for node in nodeArray {
                    print("tapped \(node.name!)")
                    if (node.name == "Start"){
                        initial()
                        start.isHidden = true
                        isRunning = true
                        startTheGame()
                    }
                }
            }
        }
    }
    
    func pickFood(food: String){
        if isRunning{
            let foodItem = SKSpriteNode(imageNamed: food + ".png")
            foodItem.name = food
            foodItem.physicsBody = SKPhysicsBody(rectangleOf: foodItem.frame.size)
            foodItem.physicsBody?.affectedByGravity = true
            foodItem.physicsBody?.contactTestBitMask = 0b0001
            //let Width  = (UIScreen.main.fixedCoordinateSpace.bounds.width)/2
            //let Height = (UIScreen.main.fixedCoordinateSpace.bounds.height)/2
            let randH = double_t.random(in: 0..<333.5)
            let randW = double_t.random(in: -187.5 ... 187.5)
            //print("width is \(Width)")
            foodItem.position.x = CGFloat(randW)
            foodItem.position.y = CGFloat(randH)
            self.addChild(foodItem)
            //print("adding \(foodItem.name!)")
            }
        }
        
    
    func update(timer: Timer) {
           if isRunning {
               self.score.text = "Score: \(self.scoreNum!)"
               self.missesLeft.text = "Misses: \(self.missesNum!)"
               let foodItem = foods.randomElement()
               pickFood(food: foodItem!)
           }
    }
    
    func initial(){
        self.isRunning = false
        self.isPaused = true
        self.gameOver.isHidden = true
        self.yourScore.isHidden = true
        self.scoreNum = 0
        self.missesNum = 3
        self.missesLeft.text = ("Misses Left: \(missesNum!)")
        self.score.text = ("Score: \(scoreNum!)")
    }
    
    func startTheGame(){
        self.gameOver.isHidden = true
        self.yourScore.isHidden = true
        self.isRunning = true
        self.isPaused = false
        bagSprite.position.x = 0.0
        bagSprite.position.y = -625
        self.addChild(bagSprite)
    }
    
    func endTheGame(){
        isRunning = false
        self.isPaused = true
        bagSprite.removeFromParent()
        self.gameOver.isHidden = false
        self.yourScore.text = "Your Score: \(self.scoreNum!)"
        self.yourScore.isHidden = false
        self.start.isHidden = false
        scoreNum = 0
        missesNum = 3
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        print("nodeA = \(nodeA.name!), nodeB = \(nodeB.name!)")
        if (nodeA.name! == "bag" || nodeB.name! == "bag" ) {
            self.scoreNum += 1
            self.score.text = "Score: \(self.scoreNum!)"
            if (nodeA.name! == "bag") {
                nodeB.removeFromParent()
            } else {
                nodeA.removeFromParent() }
        }
        else if (nodeA.name! == "Wall" || nodeB.name! == "Wall") {
            self.missesNum -= 1
            if (nodeA.name! == "Wall") {
                nodeB.removeFromParent()
            } else {
                nodeA.removeFromParent() }
            self.missesLeft.text = "Misses: \(self.missesNum!)"
            if (self.missesNum == 0) {
                bagSprite.removeFromParent()
                endTheGame()
                for fooditem in foods {
                    print("food item \(fooditem)")
                    if let Node = self.childNode(withName: fooditem) {
                        print("node item \(fooditem)")
                        self.removeChildren(in: [Node])
                    }
                }
            }
        }
    }
}
