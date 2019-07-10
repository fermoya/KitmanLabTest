//
//  LoginViewModel.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation
import Repository

protocol LoginViewModelObserver: class {
    func userDidLoginSuccessfully()
    func userDidLoginWithError(_ error: WebserviceError)
}

class LoginViewModel {
    
    private weak var observer: LoginViewModelObserver!
    private var repository: Webservice = Webservice()
    
    init(observer: LoginViewModelObserver) {
        self.observer = observer
    }
    
    func login(with email: String, password: String) {
        repository.login(email: email, password: password) { [weak self] (result) in
            switch result {
            case .success(let isOk):
                guard isOk else {
                    self?.observer?.userDidLoginWithError(.unknown("Login unsuccessful"))
                    return
                }
                self?.observer.userDidLoginSuccessfully()
            case .failure(let error):
                self?.observer.userDidLoginWithError(error)
            }
        }
    }
    
}
