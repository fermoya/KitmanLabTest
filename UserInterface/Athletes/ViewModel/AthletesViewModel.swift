//
//  AthletesViewModel.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import Domain
import Repository

protocol AthletesViewModelObserver: class {
    func didReceive(athletes: [Athlete])
    func didReceive(error: WebserviceError)
}

class AthletesViewModel {
    
    private weak var observer: AthletesViewModelObserver!
    private var repository: Webservice = Webservice()
    
    init(observer: AthletesViewModelObserver) {
        self.observer = observer
    }
    
    func fetchAthletesAndSquads() {
        repository.fetchAthletes { [weak self] (result) in
            switch result {
            case .success(let athletes):
                self?.observer.didReceive(athletes: athletes)
            case .failure(let error):
                self?.observer.didReceive(error: error)
            }
        }
    }
}
