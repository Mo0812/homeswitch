//
//  FirstViewController.swift
//  homeswitch
//
//  Created by Moritz Kanzler on 25.03.16.
//  Copyright © 2016 Moritz Kanzler. All rights reserved.
//

import UIKit

class SwitchesViewController: UIViewController {
    
    var switches: [HSSwitch]?

    @IBOutlet weak var switchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchTable.dataSource = self
        switchTable.delegate = self
        
        switches = HSSwitch.loadSwitches()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        switches = HSSwitch.loadSwitches()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    @IBAction func toggleAllOff(sender: AnyObject) {

            let urlStr = ServerGlobal.ServerConnection.serverAddrBaseUrl + "/setSwitch.php?switch_id=all&state=0"
            let url = NSURL(string: urlStr)
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
                (data, response, error) in
                // your condition on success and failure
            }
            task.resume()
            
    }
    
    @IBAction func toggleAllOn(sender: AnyObject) {
        
        let urlStr = ServerGlobal.ServerConnection.serverAddrBaseUrl + "/setSwitch.php?switch_id=all&state=1"
        let url = NSURL(string: urlStr)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            // your condition on success and failure
        }
        task.resume()
        
    }
    
    @IBAction func cancelToSwitchesView(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveToSwitchesView(segue: UIStoryboardSegue) {
        if let switchAddController = segue.sourceViewController as? SwitchesAddTableViewController {
            print(switchAddController.switchName.text)
        }
            
    }

}

extension SwitchesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SwitchTableViewCell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchTableViewCell
        
        if let switch_arr = switches {
            let model = switch_arr[indexPath.row]
            cell.switchModel = model
            cell.switchName.text = model.name
            cell.switchIcon.image = model.typeimage
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let switch_arr = switches {
            return switch_arr.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let swOn = UITableViewRowAction(style: .Normal , title: "  An  ") { action, index in
            if let switch_arr = self.switches {
                let thisSwitch = switch_arr[indexPath.row]
                thisSwitch.turnOnOff(true)
            }
            tableView.setEditing(false, animated: true)
        }
        swOn.backgroundColor = UIColor.init(red: 0/255, green: 153/255, blue: 0/255, alpha: 1.0)
        
        let swOff = UITableViewRowAction(style: .Normal, title: " Aus ") { action, index in
            if let switch_arr = self.switches {
                let thisSwitch = switch_arr[indexPath.row]
                thisSwitch.turnOnOff(false)
            }
            tableView.setEditing(false, animated: true)
        }
        swOff.backgroundColor = UIColor.init(red: 179/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        return [swOff, swOn]
    }
    
}
