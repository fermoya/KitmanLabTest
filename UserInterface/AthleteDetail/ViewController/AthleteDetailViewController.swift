//
//  AthleteDetailViewController.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class AthleteDetailViewController: UIViewController {

    private var athlete: Athlete
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: SquadTableViewCell.className,
                                     bundle: Bundle(for: type(of: self))),
                               forCellReuseIdentifier: SquadTableViewCell.className)
        }
    }
    
    init(athlete: Athlete) {
        self.athlete = athlete
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        thumbnail.kf.setImage(with: URL(string: athlete.imageUrl)!)
        username.text = athlete.userName
        fullName.text = "\(athlete.firstName) \(athlete.lastName)"
    }

}

extension AthleteDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athlete.squads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SquadTableViewCell.className) as! SquadTableViewCell
        cell.squad = athlete.squads[indexPath.row]
        return cell
    }
    
}
