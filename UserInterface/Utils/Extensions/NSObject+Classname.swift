//
//  NSObject+Classname.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation

extension NSObject {
    
    public class var className: String {
        return String(describing: self)
    }
}
