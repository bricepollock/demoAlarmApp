//
//  ViewController.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let alarmService = HandshakeAlarmService()
    var alarms = HandshakeAlarmResponse()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.global().async { [weak self] in
            self?.alarmService.getAlarms { (alarms) in
                DispatchQueue.main.async { [weak self] in
                    guard let alarms = alarms else { return }
                    self?.alarms = alarms
                    self?.view.setNeedsLayout()
                }
            }
        }
    }
}

