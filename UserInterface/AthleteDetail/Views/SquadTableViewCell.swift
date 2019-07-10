//
//  SquadTableViewCell.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit
import Domain

class SquadTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    
    var squad: Squad! { didSet { setUpUI() } }
    
    func setUpUI() {
        name.text = squad.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        creationDate.text = "Since \(dateFormatter.string(from: squad.creationDate))"
    }
    
}
