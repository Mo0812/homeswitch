//
//  StartScreenViewController.swift
//  homeswitch
//
//  Created by Moritz Kanzler on 03.04.16.
//  Copyright © 2016 Moritz Kanzler. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var serverAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        password.text = ServerGlobal.ServerConnection.serverPassword
        password.secureTextEntry = true
        serverAddress.text = ServerGlobal.ServerConnection.serverAddrBaseUrl
        
        self.password.layer.cornerRadius =  5.0
        self.password.layer.masksToBounds = true
        self.serverAddress.layer.cornerRadius = 5.0;
        self.serverAddress.layer.masksToBounds = true
        
        let paddingLeftP = UIView(frame: CGRectMake(0, 0, 15, self.password.frame.size.height))
        let paddingLeftSA = UIView(frame: CGRectMake(0, 0, 15, self.serverAddress.frame.size.height))
        //Adding the padding to the second textField
        password.leftView = paddingLeftP
        password.leftViewMode = UITextFieldViewMode .Always
        serverAddress.leftView = paddingLeftSA
        serverAddress.leftViewMode = UITextFieldViewMode .Always
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoSwitchView(sender: AnyObject) {
        if(ServerGlobal.ServerConnection.testConnection(password.text!, newUrl: serverAddress.text!)) {
            ServerGlobal.ServerConnection.serverPassword = password.text!
            ServerGlobal.ServerConnection.serverAddrBaseUrl = serverAddress.text!
            performSegueWithIdentifier("gotoSwitchScreen", sender: self)
        } else {
            let alertController = UIAlertController(title: "homeswitch", message:
                "Passwort oder Serveradresse waren nicht korrekt, bitte versuche es erneut", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
