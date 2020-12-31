//
//  Extensions.swift
//  SmartCart
//
//  Created by Yasir Tahir Ali on 21/11/2020.
//

import Foundation
import UIKit
import Alamofire

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension Request {
 public func debugLog() -> Self {
  #if DEBUG
     debugPrint(self)
  #endif
  return self
  }
}
