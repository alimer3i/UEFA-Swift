//
//  StringExtension.swift
//  PalmReading
//
//  Created by Ali Merhie on 9/16/19.
//  Copyright © 2019 Monty Mobile. All rights reserved.
//

import Foundation

extension String {
    func trimKW() -> String {
      return trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
      guard
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
        let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
        let from = String.Index(from16, within: self),
        let to = String.Index(to16, within: self)
        else { return nil }
      return from ..< to
    }

    func UTCToLocal(formatIn: String) -> String {
        let calendar = Calendar.current

        let dateFormatter = DateFormatter() 
        dateFormatter.dateFormat = formatIn
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm aa"
        return dateFormatter.string(from: dt)

        //check how old is the date and view string as full date or past hours
//        let components = calendar.dateComponents([.day], from: dt ?? Date(), to: Date())
//        if (components.day ?? 0) > 2 {
//        return dateFormatter.string(from: dt!)
//        }
//        return dt?.timeAgo() ?? ""
    }
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var containsSpecialCharacters: Bool {
        let passwordRegex = ".*[^A-Za-z0-9].*"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self.replacingOccurrences(of: " ", with: ""))
    }
}

extension String {
    var passwordValidated: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
