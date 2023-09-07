//
//  CanvasView.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-05.
//

import UIKit

/// 낙서 구조체
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

/// 낙서를 그릴 수 있는 캔버스
class CanvasView: UIView {
    
    let colors: [CGColor] = [
        
        UIColor.black.cgColor,
        UIColor.systemRed.cgColor,
        UIColor.systemPink.cgColor,
        UIColor.systemOrange.cgColor,
        UIColor.systemYellow.cgColor,
        UIColor.systemGreen.cgColor,
        UIColor.systemBlue.cgColor,
        UIColor.systemIndigo.cgColor,
        
    ]
    
    var currentStrokeWidth: CGFloat = 3.0
    
    var currentStrokeColor: UIColor = .black
    
    private var doodleGroup: [Doodle] = []
    
    private var currentStroke: [CGPoint] = []
    
    private var storedStroke: [CGPoint] = []
    
    
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
        
        guard let stroke = doodleGroup.popLast() else { return }
        //storedStroke.append(stroke.point)
        setNeedsDisplay()
        
    }
    
    func redo() {
        
        guard let stroke = storedStroke.popLast() else { return }
        
        currentStroke.append(stroke)
        
        setNeedsDisplay()
        
    }
    
    func renderCanvasViewToImage() -> UIImage? {
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { _ in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
        
    }
    
}
