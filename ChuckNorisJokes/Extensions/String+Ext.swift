//
//  String+Ext.swift
//  ChuckNorisJokes
//
//  Created by Kinney Kare on 12/18/22.
//

import UIKit

extension String {
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}
