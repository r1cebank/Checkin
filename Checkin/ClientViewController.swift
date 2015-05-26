//
//  ClientViewController.swift
//  Checkin
//
//  Created by Siyuan Gao on 5/25/15.
//  Copyright (c) 2015 Siyuan Gao. All rights reserved.
//

import UIKit
import Foundation
import SwiftSpinner
import MultipeerConnectivity

class ClientViewController: UIViewController, MPCManagerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var freq: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = freq
    }
    
    override func viewWillAppear(animated: Bool) {
        appDelegate.mpcManager.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        log.verbose("Received data from host")
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        let data = receivedDataDictionary["data"] as? NSData
        let dataDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! Dictionary<String, String>
        if let message = dataDictionary["message"] {
            log.verbose("Received: \(message)")
            if(message == "checkin") {
                dispatch_async(dispatch_get_main_queue(),{
                    self.performSegueWithIdentifier("showCheckInViewSegue", sender: nil)
                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func foundPeer() {
    }
    func lostPeer() {
    }
    func invitationWasReceived(fromPeer: String) {
    }
    func connectedWithPeer(peerID: MCPeerID) {
        dispatch_async(dispatch_get_main_queue(),{
            SwiftSpinner.hide()
        })
    }
    func disconnectedWithPeer(peerID: MCPeerID) {
        dispatch_async(dispatch_get_main_queue(),{
            SwiftSpinner.show("waiting for host", animated: true)
        })
    }
    
    override func didReceiveMemoryWarning() {
    }
}