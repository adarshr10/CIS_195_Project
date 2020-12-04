//
//  StockTableViewController.swift
//  final
//
//  Created by Adarsh Rao on 12/2/20.
//  Copyright © 2020 Adarsh Rao. All rights reserved.
//

import UIKit
import Foundation


class StockTableViewController: UITableViewController {
    
    var sp: [fullCompany] = [];
    let companyEndpoint = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl();
        refreshControl?.addTarget(self, action:
        #selector(handleRefreshControl),
        for: .valueChanged)
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
//        print(sp)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func makeAPICall() {
        let url = URL(string: companyEndpoint)!;
        let req = URLRequest(url: url);

        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error");
                return
            }
//            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            if let APIRes = try? JSONDecoder().decode([Company].self, from: data) {
                DispatchQueue.main.async {
                    for index in 1...20 {
                        let ticker: String = APIRes[index].symbol;
                        let analURL: URL = URL(string: "")!;
//                        print(APIRes[index]);
                        print(index);
                        let anal: Analysis = self.analysisCall(with: analURL)!;
                        let comp = fullCompany(company: APIRes[index], analysis: anal);
//                        var ref: DocumentReference? = nil
//                        ref = self.db.collection("parks").addDocument(data: [
//                            "fullName": park.fullName,
//                            "description": park.description,
//                            "designation": park.designation,
//                            "images": urls
//                        ]) { err in
//                            if let err = err {
//                                print("Error adding document: \(err)")
//                            } else {
//                                print("Document added with ID: \(ref!.documentID)")
//                            }
//                        }
//                        print("hello")
//                        print(comp)
                        self.sp.append(comp);
                    }

                    self.tableView.reloadData();
//                    print(self.sp);
                }
            }
        }
        task.resume();

    }
    
    private func analysisCall(with url: URL) -> Analysis? {
        let req = URLRequest(url: url);
        var result: Analysis?
        
        let semaphore = DispatchSemaphore(value: 0)

        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error");
                return
            }
//            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            if let APIRes = try? JSONDecoder().decode([Analysis].self, from: data) {
                result = APIRes[0]
//                print(result)
                
                semaphore.signal()
            }
        }
        task.resume();
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
//        print(result)
        return result;
    }
    
    @objc func handleRefreshControl() {
        makeAPICall();

       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.refreshControl?.endRefreshing()
       }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sp.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        
        if let label = cell.viewWithTag(1) as? UILabel{
            label.text = sp[indexPath.row].company.name;
        }
        
        
        if let designation = cell.viewWithTag(2) as? UILabel{
            designation.text = sp[indexPath.row].company.sector;
        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetailsSegue", sender: sp[indexPath.row]);
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "ShowDetailsSegue" {
            if let s = segue.destination as? StockDetailViewController {
                let analysis = sender as! fullCompany
                s.buyNum = analysis.analysis.buy;
                s.sellNum = analysis.analysis.sell;
                s.holdNum = analysis.analysis.hold;
                s.strongBuyNum = analysis.analysis.strongBuy;
                s.strongSellNum = analysis.analysis.strongSell;
                s.name = analysis.company.name;
            }
        }
    }
    
    
    
    

    // MARK: - Table view data source



    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
