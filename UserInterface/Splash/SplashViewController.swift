//
//  SplashViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 11/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit

public class SplashViewController: UIViewController {

    private var transition: RevealTransition!

    @IBOutlet weak var logo: UIImageView! {
        didSet {
            logo.image = UIImage(named: "app-logo", in: Bundle.main, compatibleWith: nil)
            transition = RevealTransition(view: logo)
        }
    }
    
    public init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [unowned self] in
            let loginViewController = LoginViewController()
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = nil
    }

}

extension SplashViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return operation == .push ? transition : nil
    }
    
}

