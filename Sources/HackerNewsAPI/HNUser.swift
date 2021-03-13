//
//  File.swift
//  
//
//  Created by Jann Schafranek on 13.03.21.
//

import Foundation

public struct HNUser: Codable, Equatable {
    
    /// The user's unique username. Case-sensitive. Required.
    public let id: String
    /// Creation date of the user, in Unix Time.
    public let created: Date?
    /// The user's karma.
    public let karma: Int?
    /// The user's optional self-description. HTML.
    public let about: String?
    /// List of the user's stories, polls and comments.
    public let submitted: [Int]?
}
