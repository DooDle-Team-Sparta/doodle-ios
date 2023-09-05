//
//  CanvasView.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-05.
//

import UIKit

class CanvasView: UIView {
    
    private var lines = [[CGPoint]]()
    
    
    // MARK: - User touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lines.append([CGPoint]())
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        
        lastLine.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    // MARK: - drawing
    // 나중에 context 주입 부분을 분리해도 될 것 같음
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.black.cgColor)
        
        context.setLineWidth(3)
        
        context.setLineCap(.round)
        
        for line in lines {
            
            for (index, point) in line.enumerated() {
                
                if index == 0 {
                    
                    context.move(to: point)
                    
                } else {
                    
                    context.addLine(to: point)
                    
                }
            }
            
            context.strokePath()
            
        }
        
    }
    
}
