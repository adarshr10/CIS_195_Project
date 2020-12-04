//
//  Goal.swift
//  final
//
//  Created by Adarsh Rao on 11/27/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults


struct Goal: Codable, DefaultsSerializable {
    var name: String
    var description: String?
    var type: String
    var amount: Int
    var date: Date
}

