//
//  LoginViewController.swift
//  KitmanLabsTest
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit
import Domain
import Repository
import SpinKitFramework

public class LoginViewController: UIViewController {

    @IBOutlet weak var spinner: ChasingDotsSpinner! { didSet { spinner.isHidden = true } }
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var email: String { return emailTextField.text ?? "" }
    private var password: String { return passwordTextField.text ?? "" }
    
    private lazy var viewModel: LoginViewModel = LoginViewModel(observer: self)
    
    @IBAction func userDidTapLogIn(_ sender: UIButton) {
        guard !email.isEmpty, !password.isEmpty else { return showError(title: "Something went wrong", message: "Please, fill in all the text boxes in order to log in") }
        
        loginButton.isEnabled = false
        spinner.isHidden = false
        spinner.startLoading()
        viewModel.login(with: email, password: password)
    }
    
    public init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewModelObserver {
    func userDidLoginSuccessfully() {
        let viewController = AthletesViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func userDidLoginWithError(_ error: WebserviceError) {
        loginButton.isEnabled = false
        spinner.isHidden = true
        let message: String
        switch error {
        case .unknown(let errorMessage):
            message = errorMessage
        default:
            message = "Our severs are encountering some troubles. Please, again later"
        }
        
        showError(title: "Something went wrong", message: message)
    }
    
    
}
