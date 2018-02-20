
//
//  CreateAlarmViewController.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

class CreateAlarmViewController: UIViewController {
    let alarmService = HandshakeAlarmService()
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var userTextView: UITextView!
    
    let dismissString = "Dismiss"
    let createString = "Create"
    let titleText = "Create an Alarm"
    
    static func create() -> CreateAlarmViewController {
        let viewController: CreateAlarmViewController = createInstanceFromStoryboard()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.setTitle(dismissString, for: .normal)
        createButton.setTitle(createString, for: .normal)
        titleButton.text = titleText
        titleButton.font = UIFont.boldSystemFont(ofSize: 24)
        userTextView.becomeFirstResponder()
    }
    
    @IBAction func didPressDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressCreate(_ sender: Any) {
        alarmService.createAlarm(text: userTextView.text) { (didSucceed) in
            if didSucceed == true {
                self.dismiss(animated: true, completion: nil)
            } else {
                // TODO: show alarm view to user
            }
        }
    }
}
