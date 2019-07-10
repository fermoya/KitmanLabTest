//
//  AthletesViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit
import Domain
import Repository
import SpinKitFramework

class AthletesViewController: UIViewController {

    
    @IBOutlet weak var emptyStateMessageLabel: UILabel!
    @IBOutlet weak var spinner: WaveSpinner! { didSet { spinner.startLoading() } }
    @IBOutlet weak var emptyStateView: UIView! { didSet { emptyStateView.isHidden = true } }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private lazy var viewModel: AthletesViewModel = AthletesViewModel(observer: self)
    var athletes: [Athlete]?
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if athletes == nil {
            viewModel.fetchAthletesAndSquads()
        }
        tableView.register(UINib(nibName: AthleteTableViewCell.className,
                                 bundle: Bundle(for: type(of: self))),
                           forCellReuseIdentifier: AthleteTableViewCell.className)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

extension AthletesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AthleteTableViewCell.className) as! AthleteTableViewCell
        cell.athlete = athletes![indexPath.row]
        return cell
    }
    
    private func showEmptyStateView() {
        emptyStateView.isHidden = false
        emptyStateMessageLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.emptyStateMessageLabel.transform = .identity
        }
    }
    
}

extension AthletesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let athlete = athletes![indexPath.row]
        let detailViewController = AthleteDetailViewController(athlete: athlete)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

extension AthletesViewController: AthletesViewModelObserver {
    
    func didReceive(error: WebserviceError) {
        return showEmptyStateView()
    }
    
    func didReceive(athletes: [Athlete]) {
        guard !athletes.isEmpty else {
            return showEmptyStateView()
        }
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.tableView.alpha = 1
            self?.spinner.alpha = 0
        }
        
        self.athletes = athletes
        tableView.reloadData()
    }
    
}
