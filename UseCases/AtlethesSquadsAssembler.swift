//
//  AtlethesSquadsAssembler.swift
//  UseCases
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import Domain

public protocol Athlete {
    var firstName: String { get set }
    var lastName: String { get set }
    var id: Int { get set }
    var imageUrl: String { get set }
    var userName: String { get set }
    var squadIds: [Int] { get set }
}

public class AthletesSquadsAssembler {
    
    public init() {  }
    
    public func assemble(athletes: [Athlete], squads: [Squad]) -> [Domain.Athlete] {
        
        let result: [Domain.Athlete] = athletes.map { athlete in
            let athleteSquads = squads.filter { athlete.squadIds.contains($0.id) }
            return Domain.Athlete(firstName: athlete.firstName, lastName: athlete.lastName, id: athlete.id, imageUrl: athlete.imageUrl, userName: athlete.userName, squads: athleteSquads)
        }
        
        return result
    }
    
}
