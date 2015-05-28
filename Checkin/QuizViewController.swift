//
//  QuizViewController.swift
//  Checkin
//
//  Created by Siyuan Gao on 5/28/15.
//  Copyright (c) 2015 Siyuan Gao. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner
import MultipeerConnectivity
import MKInputBoxView
import LocalAuthentication
import PXAlertView

class QuizViewController: UIViewController, MPCManagerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
    }
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        log.verbose("Received data from host")
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
    
}