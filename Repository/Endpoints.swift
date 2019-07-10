//
//  Endpoints.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation

public enum Endpoint {
    case login(email: String, password: String)
    case athletes
    case squads
    case athletesAndSquads
    
    public var url: String {
        return host + relativePath
    }
    
    public var host: String {
        return "https://kml-tech-test.glitch.me"
    }
    
    public var body: String {
        switch self {
        case .login(email: let email, password: let password):
            return "{ \"username\": \"\(email)\", \"password\": \"\(password)\"}"
        default:
            return ""
        }
    }
    
    public var relativePath: String {
        switch self {
        case .login:
            return "/session"
        case .athletes:
            return "/athletes"
        case .squads:
            return "/squads"
        case .athletesAndSquads:
            return "/org"
        }
    }
}
