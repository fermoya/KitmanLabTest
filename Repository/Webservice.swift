//
//  Webservice.swift
//  Repository
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import Alamofire
import Domain
import UseCases

typealias HttpDataResult = Swift.Result<Data, WebserviceError>
public typealias HttpAcknowledgementResult = Swift.Result<Bool, WebserviceError>
public typealias AthletesResult = Swift.Result<[Domain.Athlete], WebserviceError>

public enum WebserviceError: Error {
    case unknown(String)
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
    case unavailable
}

public class Webservice {
    
    public init() { }
    
    public func login(email: String, password: String, completion: @escaping (HttpAcknowledgementResult) -> Void) {
        let endpoint: Endpoint = .login(email: email, password: password)
        post(to: endpoint) { (result) in
            switch result {
            case .success:
                return completion(.success(true))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    public func fetchAthletes(completion: @escaping (AthletesResult) -> Void) {
        let endpoint: Endpoint = .athletesAndSquads
        get(from: endpoint) { (result) in
            switch result {
            case .success(let data):
                let response = try! JSONDecoder().decode(AthletesAndSquadsResponse.self, from: data)
                let assembler = AthletesSquadsAssembler()
                let athletes = assembler.assemble(athletes: response.athletes, squads: response.squads)
                return completion(.success(athletes))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    private func post(to endpoint: Endpoint, completion: @escaping (HttpDataResult) -> Void) {
        var urlRequest = URLRequest(url: URL(string: endpoint.url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = endpoint.body.data(using: .utf8)
        request(urlRequest)
            .responseJSON { [weak self] (dataResponse) in
                guard let self = self else { return }
                guard let data = dataResponse.data else {
                    if let error = self.findErrors(in: dataResponse) {
                        return completion(.failure(error))
                    } else {
                        return completion(.failure(.unknown("Empty response")))
                    }
                }
                
                completion(.success(data))
        }
    }
    
    private func get(from endpoint: Endpoint, completion: @escaping (HttpDataResult) -> Void) {
        request(endpoint.url)
            .responseJSON { [weak self] (dataResponse) in
                guard let self = self else { return }
                guard let data = dataResponse.data else {
                    if let error = self.findErrors(in: dataResponse) {
                        return completion(.failure(error))
                    } else {
                        return completion(.failure(.unknown("Empty response")))
                    }
                }
                
                completion(.success(data))
        }
    }
    
    private func findErrors<T>(in dataResponse: DataResponse<T>) -> WebserviceError? {
        guard let error = dataResponse.error else { return nil }
        
        if let httpCode = dataResponse.response?.statusCode {
            return processHttpErrorResponse(with: httpCode)
        } else {
            return .unknown(error.localizedDescription)
        }
        
    }
    
    private func processHttpErrorResponse(with code: Int) -> WebserviceError {
        let error: WebserviceError
        switch code {
        case 400:
            error = .badRequest
        case 401:
            error = .unauthorized
        case 403:
            error = .forbidden
        case 404:
            error = .notFound
        case 500:
            error = .internalServerError
        case 502:
            error = .badGateway
        case 503:
            error = .unavailable
        default:
            error = .unknown("HTTP code \(code)")
        }
        return error
    }
    
}
