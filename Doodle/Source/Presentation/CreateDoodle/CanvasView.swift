//
//  CanvasView.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-05.
//

import SnapKit
import Then
import UIKit

struct Doodle {
    
    var color: UIColor
    
    var weight: CGFloat
    
    var point: [CGPoint]
    
    init(color: UIColor, weight: CGFloat, point: [CGPoint]) {
        
        self.color = color
        
        self.weight = weight
        
        self.point = point
        
    }
    
}

class CanvasView: UIView {
    
    var currentStrokeWidth: CGFloat = 3.0
    
    var currentStrokeColor: UIColor = .black
    
    private var doodleGroup: [Doodle] = []
    
    private var currentStroke: [CGPoint] = []
    
    private var storedStroke: [Doodle] = []
    
    
    // MARK: - User touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        
        currentStroke.removeAll()
        
        currentStroke.append(point)
        
        setNeedsDisplay()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        
        currentStroke.append(point)
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        addDoodle(currentStrokeColor, currentStrokeWidth, currentStroke)
        
        currentStroke.removeAll()
        
    }
    
    // MARK: - drawing
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for doodle in doodleGroup {
            
            context.setStrokeColor(doodle.color.cgColor)
            
            context.setLineWidth(doodle.weight)
            
            context.setLineCap(.round)
            
            for (index, point) in doodle.point.enumerated() {
                
                if index == 0 {
                    
                    context.move(to: point)
                    
                } else {
                    
                    context.addLine(to: point)
                    
                }
                
            }
            
            context.strokePath()
        }
        
        context.setStrokeColor(currentStrokeColor.cgColor)
        
        context.setLineWidth(currentStrokeWidth)
        
        context.setLineCap(.round)
        
        for (index, point) in currentStroke.enumerated() {
            
            if index == 0 {
                
                context.move(to: point)
                
            } else {
                
                context.addLine(to: point)
                
            }
            
        }
        
        context.strokePath()
    }
    
}

extension CanvasView {
    
    func addDoodle(_ color: UIColor, _ weight: CGFloat, _ point: [CGPoint]) {
        
        let doodle = Doodle(color: color, weight: weight, point: point)
        
        doodleGroup.append(doodle)
        
        setNeedsDisplay()
        
    }
    
    func clear() {
        
        doodleGroup.removeAll()
        
        setNeedsDisplay()
        
    }
    
    func undo() {
        
        guard let lastDoodle = doodleGroup.popLast() else { return }
        
        storedStroke.append(lastDoodle)
        
        setNeedsDisplay()
        
        print("DoodleGroup: \(doodleGroup)")
        
    }
    
    func redo() {
        
        guard let lastDoodle = storedStroke.popLast() else { return }
        
        doodleGroup.append(lastDoodle)
        
        setNeedsDisplay()
        
        print("DoodleGroup: \(doodleGroup)")
        
    }
    
    func renderCanvasViewToImage() -> Data? {
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        let image = renderer.image { _ in
            
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            
        }
        
        return image.pngData()
        
    }
    
}
