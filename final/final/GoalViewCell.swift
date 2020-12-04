//
//  GoalViewCell.swift
//  final
//
//  Created by Adarsh Rao on 11/27/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import UIKit

class GoalViewCell: UICollectionViewCell {
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func configure(goal: String, amount: Int, typeL: String, date: Date) {
        goalLabel.text = "Name: \(goal)";
        amountLabel.text = "Amount: \(String(amount))";
        typeLabel.text = "Type: \(typeL)";
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        dateLabel.text = "Date: \(df.string(from:date))";
        
    }
    
}
