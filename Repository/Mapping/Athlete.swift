//
//  Athlete.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import UseCases

struct Athlete: Decodable, UseCases.Athlete {
    
    var firstName: String
    var lastName: String
    var id: Int
    var imageUrl: String
    var userName: String
    var squadIds: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userName = "username"
        case squadIds = "squad_ids"
        case imageUrl = "image"
        case id
    }
    
    init(firstName: String, lastName: String, id: Int, imageUrl: String, userName: String, squadIds: [Int]) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.imageUrl = imageUrl
        self.userName = userName
        self.squadIds = squadIds
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let firstName = try! container.decode(String.self, forKey: .firstName)
        let lastName = try! container.decode(String.self, forKey: .lastName)
        let userName = try! container.decode(String.self, forKey: .userName)
        let squadIds = try! container.decode([Int].self, forKey: .squadIds)
        let id = try! container.decode(Int.self, forKey: .id)
        let dic = try! container.decode([String: String].self, forKey: .imageUrl)
        let imageUrl = dic["url"]!
        
        self.init(firstName: firstName, lastName: lastName, id: id, imageUrl: imageUrl, userName: userName, squadIds: squadIds)
    }
    
}
