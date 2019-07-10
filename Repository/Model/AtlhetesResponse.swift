//
//  AtlhetesResponse.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import Domain

struct AthletesResponse: Decodable {
    var athletes: [Athlete]
}
