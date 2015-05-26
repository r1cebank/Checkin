//
//  CheckInViewController.swift
//  Checkin
//
//  Created by Siyuan Gao on 5/26/15.
//  Copyright (c) 2015 Siyuan Gao. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner
import MultipeerConnectivity
import MKInputBoxView
import LocalAuthentication
import PXAlertView

class CheckInViewController: UIViewController, MPCManagerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        appDelegate.mpcManager.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func checkinClicked(sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Checkin with Touch ID"
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
                (success: Bool, error: NSError!) in
                if success {
                    PXAlertView.showAlertWithTitle("Success!", message: "You are checked in")
                } else {
                    PXAlertView.showAlertWithTitle("Failed!", message: "You are not checked in")
                    return
                }
            })
        } else {
            PXAlertView.showAlertWithTitle("Caution", message: "Touch ID is not found")
        }
        let inputBox = MKInputBoxView.boxOfType(MKInputBoxType.PlainTextInput)
        inputBox.setTitle("Who are you?")
        inputBox.setMessage("Please enter your identifier.")
        inputBox.setBlurEffectStyle(UIBlurEffectStyle.ExtraLight)
        inputBox.onSubmit = {
            (String val1, String val2) -> Void in
            log.verbose(val1)
            self.id = val1
            let message: [String : String] = ["checkin" : self.id]
            let data: [String : AnyObject] = ["message" : message]
            self.appDelegate.mpcManager.sendData(dictionaryWithData: data, toPeer: self.appDelegate.mpcManager.session.connectedPeers[0] as! MCPeerID)
            PXAlertView.showAlertWithTitle("Success!", message: "You are checked in")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        inputBox.show()
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