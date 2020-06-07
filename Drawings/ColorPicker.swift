//
//  ColorPicker.swift
//  Drawings
//
//  Created by Vladislav on 6/7/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate {
    func ColorPickerTouched(sender:ColorPicker, color:UIColor, point:CGPoint)
}

//@IBDesignable
class ColorPicker: UIView {

    var delegate: ColorPickerDelegate?
    let saturationExponentTop:Float = 1.3
    let saturationExponentBottom:Float = 0.3
    
    var elementSize: CGFloat = 34.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private func initialize() {
         self.clipsToBounds = true
         let touchGesture = UIPanGestureRecognizer(target: self, action: #selector(self.touchedColor(gestureRecognizer:)))
//         touchGesture.minimumPressDuration = 0
//         touchGesture.allowableMovement = CGFloat.greatestFiniteMagnitude
         self.addGestureRecognizer(touchGesture)
     }

    override init(frame: CGRect) {
         super.init(frame: frame)
         initialize()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         initialize()
     }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        for y : CGFloat in stride(from: 0.0 ,to: rect.height, by: elementSize) {
            var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
            saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
            for x : CGFloat in stride(from: 0.0 ,to: rect.width, by: elementSize) {
                let hue = x / rect.width
                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                context!.setFillColor(color.cgColor)
                context!.fill(CGRect(x:x, y:y, width:elementSize, height:elementSize))
            }
        }
    }
    
    
    func getColorAtPoint(point:CGPoint) -> UIColor {
        let roundedPoint = CGPoint(x:elementSize * CGFloat(Int(point.x / elementSize)),
                               y:elementSize * CGFloat(Int(point.y / elementSize)))
        var saturation = roundedPoint.y < self.bounds.height / 2.0 ? CGFloat(2 * roundedPoint.y) / self.bounds.height
        : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        saturation = CGFloat(powf(Float(saturation), roundedPoint.y < self.bounds.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
        let brightness = roundedPoint.y < self.bounds.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        let hue = roundedPoint.x / self.bounds.width
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }

    @objc func touchedColor(gestureRecognizer: UIPanGestureRecognizer) {
        let point = gestureRecognizer.location(in: self)
        let color = getColorAtPoint(point: point)
        delegate?.ColorPickerTouched(sender: self, color: color, point: point)
    }

}
