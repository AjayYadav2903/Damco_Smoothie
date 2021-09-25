//
//  CommonFunctions.swift
//  Smoothie
//
//  Created by Ajay Yadav on 25/09/21.
//

import Foundation
import UIKit

class CommonFunctions: NSObject {
    
    public static let sharedInstance: CommonFunctions = CommonFunctions()
    
    private override init() {}
    
    func setAttributedText(textOne: String, textTwo: String, colorOne: UIColor, colorSecond: UIColor, fontOne: UIFont, fontTwo: UIFont)->NSAttributedString{
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: colorOne, NSAttributedString.Key.font: fontOne]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: colorSecond, NSAttributedString.Key.font: fontTwo]
        
        let textPartOne = NSMutableAttributedString(string: textOne, attributes: textAttributesOne)
        let textPartTwo = NSMutableAttributedString(string: textTwo, attributes: textAttributesTwo)
        
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "EEEE, MMM d"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        return formattedDate
    }

}
