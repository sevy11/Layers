//
//  LYButton.swift
//  Layers
//
//  Created by Michael Sevy on 5/15/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import UIKit

/**
    A base class for having subclasses of
    `UIButton`. It also defines and sets
    default attributes for an instance.
*/
@IBDesignable class LYButton: UIButton {

    // MARK: - IBInspectable
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var colorBackground: UIColor = .main {
        didSet {
            backgroundColor = colorBackground
        }
    }
}

