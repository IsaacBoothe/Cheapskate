//
//  Questions.swift
//  CheapSkate
//
//  Created by Isaac Kim on 11/27/23.
//

import SwiftUI

// MARK: Quiz Questions Codable Model
struct Questions: Identifiable, Codable {
    var id: UUID = .init()
    var answer: String
    var choice: [String]
    var question: String
    var explanation: String
    
    // for UI State Updates
    var tappedAnswer: String = ""
    
    enum CodingKeys: CodingKey{
        case answer
        case choice
        case question
        case explanation
    }
}

