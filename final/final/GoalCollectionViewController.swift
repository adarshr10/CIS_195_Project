//
//  GoalCollectionViewController.swift
//  final
//
//  Created by Adarsh Rao on 11/27/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import UIKit
import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var myArr: DefaultsKey<[Goal]> { .init("goals", defaultValue: []) }
}

class GoalCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AddGoalDelegate, UpdateGoalDelegate{
    
//    var goalCells: [Goal] = [Goal(name: "hello", description: nil, type: "what", amount: 22, date: Date())];
    var goalCells: [Goal] = [];
    
    @IBAction func AddGoalButton(_ sender: Any) {
    }
    
    @IBOutlet weak var goalView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalView.delegate = self;
        goalView.dataSource = self;
        goalCells = Defaults[\.myArr];
        
    }
    
    @objc func deleteCell(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! UICollectionViewCell
        let i = self.goalView.indexPath(for: cell)!.item
        self.goalCells.remove(at: i);
        goalCells.sort { (a:Goal, b:Goal) in
            return a.amount < b.amount;
        }
        Defaults[\.myArr] = goalCells;
        self.goalView.reloadData();
    }
    
    func didCreate(_ goal: Goal) {
        print("called")
        dismiss(animated: true, completion: nil);
        goalCells.append(goal);
        goalCells.sort { (a:Goal, b:Goal) in
            return a.amount < b.amount;
        }
        Defaults[\.myArr] = goalCells;
        self.goalView.reloadData();
    }
    
    func editAmount(_ amount: Int, index: Int) {
        print("called")
        dismiss(animated: true, completion: nil);
        goalCells[index].amount = goalCells[index].amount - amount;
        goalCells.sort { (a:Goal, b:Goal) in
            return a.amount < b.amount;
        }
        Defaults[\.myArr] = goalCells;
        self.goalView.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalCells.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell();
        if let goalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GoalViewCell {
            
            goalCell.shadowDecorate();
            goalCell.configure(goal: goalCells[indexPath.row].name, amount: goalCells[indexPath.row].amount, typeL: goalCells[indexPath.row].type, date: goalCells[indexPath.row].date);
            
            goalCell.goalLabel.text = goalCells[indexPath.row].name
            
            cell = goalCell;
        }
        
        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.deleteCell))
        UpSwipe.direction = UISwipeGestureRecognizer.Direction.up
        cell.addGestureRecognizer(UpSwipe)


        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowCellDetailsSegue", sender: indexPath.row)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "ShowCellDetailsSegue" {
            if let s = segue.destination as? UINavigationController {
                let topView = s.topViewController as? UpdateGoalViewController;
                let index = sender as! Int
                let goal = goalCells[index];
                topView?.desc = goal.description;
                topView?.prev = goal.amount;
                topView?.i = index;
                topView!.uDelegate = self;

            } else {
                print("Fail")
            }
        }
        if segue.identifier! == "AddGoalSegue" {
            if let s = segue.destination as? UINavigationController {
                let topView = s.topViewController as? AddGoalViewController;
                topView!.delegate = self;
            }
        }
    }

}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = .init(srgbRed: 60, green: 120, blue: 240, alpha: 0.9)
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
        
    }
}
