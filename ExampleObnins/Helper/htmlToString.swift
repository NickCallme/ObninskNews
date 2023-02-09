//
//  htmlToString.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 26.01.2023.
//

import Foundation
import UIKit

extension String {
    
    var utfData: Data {
        return Data(utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        
        do {
            return try NSAttributedString(data: utfData, options: [
              .documentType: NSAttributedString.DocumentType.html,
              .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
}

func convertHtml(string: String?) -> NSAttributedString? {
    
    guard let string = string else {return nil}
    
    guard let data = string.data(using: .utf8) else {
        return nil
    }
    
    do {
        let attrStr = try NSAttributedString(data: data,
                                      options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                      documentAttributes: nil)
        let range = NSRange(location: 0, length: attrStr.length)
        let str = NSMutableAttributedString(attributedString: attrStr)
        
        str.enumerateAttribute(NSAttributedString.Key.font, in: NSMakeRange(0, str.length), options: .longestEffectiveRangeNotRequired) {
            (value, range, stop) in
            if let font = value as? UIFont {
                
                let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title2)
                let pointSize = userFont.withSize(font.pointSize)
                let customFont = UIFont.systemFont(ofSize: pointSize.pointSize)
                let dynamicText = UIFontMetrics.default.scaledFont(for: customFont)
                str.addAttribute(NSAttributedString.Key.font,
                                         value: dynamicText,
                                         range: range)
            }
        }

        str.addAttribute(NSAttributedString.Key.underlineStyle, value: 0, range: range)
        
        return NSAttributedString(attributedString: str.attributedSubstring(from: range))
    } catch {}
    return nil
    
}

public extension NSAttributedString {
    convenience init?(_ html: String) {
        guard let data = html.data(using: .unicode) else {
                return nil
        }

        try? self.init(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
}

