//
//  Squad.swift
//  Domain
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation

public struct Squad {
    public var creationDate: Date
    public var id: Int
    public var name: String
    public var organizationId: Int
    public var lastUpdate: Date
    
    public init(creationDate: Date, id: Int, name: String, organizationId: Int, lastUpdate: Date) {
        self.creationDate = creationDate
        self.id = id
        self.name = name
        self.organizationId = organizationId
        self.lastUpdate = lastUpdate
    }
}
