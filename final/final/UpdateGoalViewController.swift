//
//  UpdateGoalViewController.swift
//  final
//
//  Created by Adarsh Rao on 12/4/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import UIKit

protocol UpdateGoalDelegate: class {
    func editAmount(_ amount: Int, index: Int)
}

class UpdateGoalViewController: UIViewController {
    
    var desc: String?;
    var prev: Int?
    var i: Int = 0;
    
    weak var uDelegate: UpdateGoalDelegate?
    
    @IBOutlet weak var goalDesc: UITextView!
    @IBOutlet weak var previous: UILabel!
    @IBOutlet weak var subtract: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalDesc.text = desc;
        previous.text = "Previous Amount: \(String(prev ?? 0))";
        
        

        // Do any additional setup after loading the view.
    }
    
    func editAmount() -> Int? {
        var toSub : Int?;
        let myInt = Int(subtract.text ?? "") ?? 0;
        
        toSub = myInt;
        
        return toSub
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAdd(_ sender: Any) {
        if let update = editAmount() {
//            print(self.uDelegate)
            print(update, i);
            self.uDelegate?.editAmount(update, index: i);
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
