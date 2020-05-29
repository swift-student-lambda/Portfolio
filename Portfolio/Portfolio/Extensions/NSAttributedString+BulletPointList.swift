//
//  NSAttributedStringHelper.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

extension NSAttributedString {
    static func bulletPointList(strings: [String]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 15
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15)]

        let stringAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]

        let string = strings.map({ "•\t\($0)" }).joined(separator: "\n")

        return NSAttributedString(string: string, attributes: stringAttributes)
    }
}
