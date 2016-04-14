//
//  ServerGlobal.swift
//  homeswitch
//
//  Created by Moritz Kanzler on 25.03.16.
//  Copyright © 2016 Moritz Kanzler. All rights reserved.
//

import Foundation

class ServerGlobal {
    struct ServerConnection {
        static var serverAddrBaseUrl: String = "" {
            didSet {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(serverAddrBaseUrl, forKey: "homeswitchServerAddr")
            }
        }
        static var serverPassword: String = "" {
            didSet {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(serverAddrBaseUrl, forKey: "homeswitchSPW")
            }
        }
        
        static func testConnection(password: String, newUrl: String) -> Bool {
            let urlStr = newUrl + "/testConnection.php"
            let url = NSURL(string: urlStr)
            
            var returnVal = false
            
            let data = NSData(contentsOfURL: url!)
            if let rData = data, response = String(data: rData, encoding: NSUTF8StringEncoding) {
                if(response == "YES") {
                    returnVal = true
                }
            }
            return returnVal
        }
        
    
    }
}

