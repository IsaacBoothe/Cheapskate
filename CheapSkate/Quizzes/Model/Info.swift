//
//  Info.swift
//  CheapSkate
//
//  Created by Isaac Kim on 11/27/23.
//

import SwiftUI

// MARK: Quiz Info Codable Model
struct Info: Codable{
    var title: String
    var peopleAttended: Int
    var Rules:[String]
    
    enum CodingKeys: CodingKey{
        case title
        case peopleAttended
        case Rules
    }
}
