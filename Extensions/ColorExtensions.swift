//
//  ColorExtensions.swift
//  GrappleGuide_v1.3
//
//  Created by connorsMac on 2024-04-18.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    func toUIColor() -> UIColor {
        let uiColor = UIColor(self)
        return uiColor
    }
}

extension UIColor {
    func toColor() -> Color {
        let color = Color(self)
        return color
    }
    
    var hexString: String {
        guard let components =  cgColor.components, components.count >= 3 else {
            return "FFFFFF"
        }
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        return String(format: "%02X%02X%02X", red , green, blue)
    }
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
