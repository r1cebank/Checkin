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