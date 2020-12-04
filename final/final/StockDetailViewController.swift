//
//  StockDetailViewController.swift
//  final
//
//  Created by Adarsh Rao on 12/3/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    var buyNum: Int?
    var sellNum: Int?
    var holdNum: Int?
    var strongBuyNum: Int?
    var strongSellNum: Int?
    var name: String?;
    
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sell: UILabel!
    @IBOutlet weak var hold: UILabel!
    @IBOutlet weak var strongBuy: UILabel!
    @IBOutlet weak var strongSell: UILabel!
    @IBOutlet weak var security: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strongBuy.text = String(strongBuyNum!);
        strongSell.text = String(strongSellNum!);
        hold.text = String(holdNum!);
        buy.text = String(buyNum!);
        sell.text = String(sellNum!);
        security.text = name;
        

        // Do any additional setup after loading the view.
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
