//
//  SecondViewController.swift
//  homeswitch
//
//  Created by Moritz Kanzler on 25.03.16.
//  Copyright © 2016 Moritz Kanzler. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var effectContainer: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var abortButton: UIButton!
    
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
        
        self.password.delegate = self
        self.serverAddress.delegate = self
        
        self.saveButton.enabled = false
        self.abortButton.enabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveServerSettings(sender: AnyObject) {
        if(ServerGlobal.ServerConnection.testConnection(password.text!, newUrl: serverAddress.text!)) {
            ServerGlobal.ServerConnection.serverPassword = password.text!
            ServerGlobal.ServerConnection.serverAddrBaseUrl = serverAddress.text!
            
            let alertController = UIAlertController(title: "homeswitch", message:
                "Super, der neue Server wird jetzt angesteuert!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: {
                self.view.endEditing(true)
            })

        } else {
            let alertController = UIAlertController(title: "homeswitch", message:
                "Passwort oder Serveradresse waren nicht korrekt, bitte versuche es erneut", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            password.text = ServerGlobal.ServerConnection.serverPassword
            serverAddress.text = ServerGlobal.ServerConnection.serverAddrBaseUrl
            self.view.endEditing(true)
        }
    }

    @IBAction func abortSettings(sender: AnyObject) {
        password.text = ServerGlobal.ServerConnection.serverPassword
        serverAddress.text = ServerGlobal.ServerConnection.serverAddrBaseUrl
        self.view.endEditing(true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        self.saveButton.enabled = true
        self.abortButton.enabled = true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.saveButton.enabled = false
        self.abortButton.enabled = false
    }
    
    /*func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }*/
}
