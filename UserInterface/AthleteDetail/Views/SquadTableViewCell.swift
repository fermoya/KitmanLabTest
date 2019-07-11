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
        dateFormatter.dateFormat = "yy-MM-dd"
        dateFormatter.dateStyle = .long
        
        let date = dateFormatter.string(from: squad.creationDate)
        let attributedText = NSMutableAttributedString(string: "Since \(date)")
        attributedText.addAttribute(.font,
                                    value: UIFont.systemFont(ofSize: 15),
                                    range: NSRange(location: 0, length: 6))
        attributedText.addAttribute(.font,
                                    value: UIFont.italicSystemFont(ofSize: 15),
                                    range: NSRange(location: 6, length: date.count))
        creationDate.attributedText = attributedText
    }
    
}
