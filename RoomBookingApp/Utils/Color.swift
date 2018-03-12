//
//  Color.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/12/18.
//

import Foundation
import UIKit

class Color: UIColor {
    
    override class var green: UIColor {
        return hexColor(hex: "#009547")
    }
    
    override class var yellow: UIColor {
        return UIColor.yellow
    }
    
    override class var red: UIColor {
        return hexColor(hex: "#E31E2F")
    }
    
    override class var white: UIColor {
        return UIColor.white
    }
    
    override class var black: UIColor {
        return UIColor.black
    }
    
    override class var gray: UIColor {
        return UIColor.gray
    }
    
}

extension Color {
    
    class func hexColor(hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
