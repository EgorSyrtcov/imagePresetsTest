//
//  Color.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
 
    static func navigationLabelColor() -> UIColor {
        return UIColor(red: 179, green: 179, blue: 179)
    }
}
