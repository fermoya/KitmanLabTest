//
//  AthleteTableViewCell.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class AthleteTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var squads: UILabel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    var athlete: Athlete! { didSet { setUpUI() } }
    
    private func setUpUI() {
        username.text = athlete.userName
        fullName.text = "\(athlete.firstName) \(athlete.lastName)"
        squads.text = "Number of squads: \(athlete.squads.count)"
        thumbnail.kf.setImage(with: URL(string: athlete.imageUrl))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
    }
}
