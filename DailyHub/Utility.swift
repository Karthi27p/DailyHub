//
//  Utility.swift
//  DailyHub
//
//  Created by Karthi on 09/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension UIColor {
    public convenience init?(hex: String?) {
        guard let hex = hex else {
            return nil
        }
        
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension UIView {
    
    //MARK: Load nib and set constraints
    func commonInit(_ nibName: String) {
        guard let view = loadViewFromNib(nibName) else {
            return
        }
        view.addAsSubViewWithEqualConstraintTo(self)
    }
    
    func loadViewFromNib(_ nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func addAsSubViewWithEqualConstraintTo(_ containerView: UIView) {
        self.frame = containerView.bounds
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
            self.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0.0),
            self.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0.0),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0)
        ])
    }
    
    //MARK: Configure view properties
    func setViewStyle(_ viewStyle: DHViewProperties?) {
        guard let style = viewStyle else {
            return
        }
        
        alpha = style.opacity ?? CGFloat(1.0)
        backgroundColor = UIColor(hex: style.bgColor)
        addCornerRadius(style.cornerRadius)
        addBorder(style.border)
    }
    
    func addCornerRadius(_ cornerRadius: DHCornerRadiusStyle?) {
        guard let cornerRadius = cornerRadius else {
            return
        }
        
        roundCorners(cornerRadius.topLeft ?? CGFloat(0.0),
                     cornerRadius.topRight ?? CGFloat(0.0),
                     cornerRadius.bottomLeft ?? CGFloat(0.0),
                     cornerRadius.bottomRight ?? CGFloat(0.0))
    }
    
    private func border(_ width: CGFloat, _ borderColor: UIColor) {
        guard width != 0.0 else {
            return
        }
        let borderLayer = CAShapeLayer()
        guard let shapeLayer = layer.mask as? CAShapeLayer else {
            self.layer.borderWidth = width
            self.layer.borderColor = borderColor.cgColor
            return
        }
        borderLayer.path = shapeLayer.path 
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = width
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    func addBorder(_ border: DHBorderStyle?) {
        guard let border = border else {
            return
        }
        
        self.border(border.width ?? CGFloat(0.0), UIColor(hex: border.color) ?? .clear)
        
    }
    
    private func roundCorners(_ topLeft: CGFloat = 0.0,
                              _ topRight: CGFloat = 0.0,
                              _ bottomLeft: CGFloat = 0.0,
                              _ bottomRight: CGFloat = 0.0) {
        guard (topLeft, topRight, bottomLeft, bottomRight) != (0.0, 0.0, 0.0, 0.0) else {
            return
        }
        
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UILabel {
    
    func setTextStyle(_ textProperties: DHTextProperties?) {
        guard let textProperties = textProperties  else {
            return
        }
        
        self.textColor = UIColor(hex: textProperties.textColor)
        if let fontSize = textProperties.fontSize, let isBold = textProperties.isBold {
            self.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}
