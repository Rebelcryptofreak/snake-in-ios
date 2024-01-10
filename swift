import Foundation
import UIKit

class Snake {
    var head: SnakeNode
    var direction: CGPoint
    var nodes: [SnakeNode]
    var size: CGFloat
    
    init() {
        size = 20
        direction = CGPoint(x: size, y: 0)
        head = SnakeNode(x: 0, y: 0, size: size)
        nodes = [head]
    }
    
    func move() {
        let previousPosition = head.position
        head.position = CGPoint(x: head.position.x + direction.x, y: head.position.y + direction.y)
        
        for i in 1..<nodes.count {
            let current = nodes[i]
            let previous = nodes[i - 1]
            let temp = current.position
            current.position = previousPosition
            previousPosition = temp
        }
    }
    
    func addNode() {
        let tail = nodes.last!
        let x = tail.position.x - direction.x
        let y = tail.position.y - direction.y
        let node = SnakeNode(x: x, y: y, size: size)
        nodes.append(node)
    }
    
    func checkCollisionWithBounds(bounds: CGRect) -> Bool {
        if head.position.x < 0 || head.position.x >= bounds.width || head.position.y < 0 || head.position.y >= bounds.height {
            return true
        }
        return false
    }
    
    func checkCollisionWithNodes() -> Bool {
        for i in 1..<nodes.count {
            let node = nodes[i]
            if node.position == head.position {
                return true
            }
        }
        return false
    }
}

class SnakeNode {
    var position: CGPoint
    var size: CGFloat
    
    init(x: CGFloat, y: CGFloat, size: CGFloat) {
        self.position = CGPoint(x: x, y: y)
        self.size = size
    }
    
    func draw() -> CAShapeLayer {
        let path = UIBezierPath(rect: CGRect(x: position.x, y: position.y, width: size, height: size))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.green.cgColor
        return shapeLayer
    }
}
