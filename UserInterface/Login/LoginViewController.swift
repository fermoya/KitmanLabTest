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
    @IBOutlet weak var loginButton: Button! { didSet { loginButton.adjustsImageWhenHighlighted = false } }
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        emailTextField.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        passwordTextField.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateKeyframes(withDuration: 0.6, delay: 0.2, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6, animations: { [weak self] in
                self?.emailTextField.transform = .identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: { [weak self] in
                self?.passwordTextField.transform = .identity
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 1, animations: { [weak self] in
                self?.loginButton.transform = .identity
            })
        }, completion: nil)
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
