//
//  HSSwitch.swift
//  homeswitch
//
//  Created by Moritz Kanzler on 25.03.16.
//  Copyright © 2016 Moritz Kanzler. All rights reserved.
//

import Foundation
import UIKit

class HSSwitch {
    let id: Int
    let name: String
    let type: Int
    let typename: String
    let typeimage: UIImage?
    let systemcode: String
    let unitcode: Int
    
    init(id: Int, name: String, type: Int, typename: String, icon: String, systemcode: String, unitcode: Int) {
        self.id = id;
        self.name = name
        self.type = type
        self.typename = typename
        self.systemcode = systemcode
        self.unitcode = unitcode
        
        if let iconImage = UIImage(named: icon+"-100") {
            self.typeimage = iconImage
        } else {
            self.typeimage = UIImage(named: "idea-100")!
        }
    }
    
    internal func turnOnOff(on: Bool) {
        var state = "0"
        if(on) {
            state = "1"
        }
        
        let urlStr = ServerGlobal.ServerConnection.serverAddrBaseUrl + "/setSwitch.php?switch_id="+String(self.id)+"&state="+state
        let url = NSURL(string: urlStr)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            // your condition on success and failure
        }
        task.resume()
    }
    
    static func loadSwitches() -> [HSSwitch]? {
        var arr = [HSSwitch]()
        
        let urlString = ServerGlobal.ServerConnection.serverAddrBaseUrl + "/getSwitches.php"
        let escapedUrlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        
        let url = NSURL(string: escapedUrlString!)
        if let data = NSData(contentsOfURL: url!) {
        
        
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let switches = json as? NSArray {
                    for switchR in switches {
                        var rID: Int = 0
                        var rName: String = ""
                        var rType: Int = 0
                        var rTName: String = ""
                        var rIcon: String = ""
                        var rSC: String = ""
                        var rUC: Int = 0
                        
                        if let id = switchR["id"] as? String {
                            rID = Int(id)!
                        }
                        if let name = switchR["label"] as? String {
                            rName = name
                        }
                        if let type = switchR["type"] as? String {
                            rType = Int(type)!
                        }
                        if let tname = switchR["typename"] as? String {
                            rTName = tname
                        }
                        if let icon = switchR["icon"] as? String {
                            rIcon = icon
                        }
                        if let sc = switchR["systemcode"] as? String {
                            rSC = sc
                        }
                        if let uc = switchR["unitcode"] as? String {
                            rUC = Int(uc)!
                        }
                        
                        
                        let hssw = HSSwitch(id: rID, name: rName, type: rType, typename: rTName, icon: rIcon, systemcode: rSC, unitcode: rUC)
                        
                        arr.append(hssw)
                    }
                    
                    return arr
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
        }
        return nil
    }
    
}
