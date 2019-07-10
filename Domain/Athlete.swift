//
//  Athlete.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation

public struct Athlete {
    public var firstName: String
    public var lastName: String
    public var id: Int
    public var imageUrl: String
    public var userName: String
    public var squads: [Squad]
    
    public init(firstName: String, lastName: String, id: Int, imageUrl: String, userName: String, squads: [Squad]) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.imageUrl = imageUrl
        self.userName = userName
        self.squads = squads
    }
}
