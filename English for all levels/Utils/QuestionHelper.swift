//
//  QuestionHelper.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/21/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class QuestionHelper: NSObject {
    class func createHtmlAttrib(html: String) -> NSAttributedString{
        let sizeHtml = "<font size='5'>\(html)</font>"
        
        let attrStr = try! NSAttributedString(
            data: sizeHtml.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        return attrStr
    }
    
    class func getTestContentResult(testContent: TestContent) -> String{
        var correct = 0
        var total = 0
        for question in testContent.questions {
            if question.anwers.count > 1 {
                total = total + 1
                if question.userSelected >= 0 && question.correctAnswer == question.userSelected {
                    correct = correct + 1
                }
            }
        }
        return "\(correct)/\(total)"
    }
}
