//
//  Domain+Decodable.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import Domain

extension Squad: Decodable {
    private enum CodingKeys: String, CodingKey {
        case creationDate = "created_at"
        case id, name
        case organisationId = "organisation_id"
        case lastUpdate = "updated_at"
    }
    
    public init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let creationDateString = try! container.decode(String.self, forKey: .creationDate)
        let creationDate = dateFormatter.date(from: creationDateString)!
        
        let lastUpdateString = try! container.decode(String.self, forKey: .lastUpdate)
        let lastUpdate = dateFormatter.date(from: lastUpdateString)!
        
        let name = try! container.decode(String.self, forKey: .name)
        let organizationId = try! container.decode(Int.self, forKey: .organisationId)
        let id = try! container.decode(Int.self, forKey: .id)
        
        self.init(creationDate: creationDate, id: id, name: name, organizationId: organizationId, lastUpdate: lastUpdate)
    }
}

