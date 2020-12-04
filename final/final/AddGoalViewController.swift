//
//  AddContactViewController.swift
//  final
//
//  Created by Adarsh Rao on 12/2/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import UIKit

protocol AddGoalDelegate: class {
    func didCreate(_ goal: Goal)
}

class AddGoalViewController: UIViewController {
    
    @IBOutlet weak var goalName: UITextField!
    
    weak var delegate: AddGoalDelegate?
    
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var targetAmount: UITextField!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var datePick: UIDatePicker!
    
    override func viewDidLoad() {
        targetAmount.keyboardType = .numberPad
        super.viewDidLoad()

    }
    
    func createNewGoal() -> Goal? {
        var toAdd : Goal?;
        if (goalName.text != nil && type != nil && targetAmount != nil && datePick != nil) {
            toAdd = Goal(name: goalName!.text!, description: Description!.text!, type: type!.text!, amount: Int(targetAmount!.text!) ?? 0, date: datePick!.date);
        }
        return toAdd;
    }
    @IBAction func cancelAdd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAdd(_ sender: Any) {
        if let goal = createNewGoal() {
            self.delegate?.didCreate(goal);
        }
    }

}
