//
//  ViewController.swift
//  AlarmApp
//
//  Created by Brice Pollock on 2/20/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import UIKit

class AlarmsListViewController: UIViewController {
    let alarmService = HandshakeAlarmService()
    let processor = AlarmsListViewControllerProcessor()
    var alarms = HandshakeAlarmResponse()
    var alarmsViewData = [AlarmTableViewCellData]()
    
    let newAlarmString = "New Alarm"
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmTableViewCell.register(in: tableView)
        
        let createButton = UIBarButtonItem(title: newAlarmString, style: .plain, target: self, action: #selector(createAlarm))
        navigationItem.rightBarButtonItem = createButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestAlarmData()
    }
    
    func requestAlarmData() {
        DispatchQueue.global().async { [weak self] in
            self?.alarmService.getAlarms { [weak self] (alarms) in
                guard let `self` = self else { return }
                guard let alarms = alarms else { return }
                self.alarms = alarms
                self.alarmsViewData = self.processor.createViewData(for: alarms, actionDelegate: self)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func createAlarm() {
        let creationVC = CreateAlarmViewController.create()
        present(creationVC, animated: true, completion: nil)
    }
}

extension AlarmsListViewController: AlarmTableViewCellDelegate {
    func didPressUpvote(_ didUpvote: Bool, for alarm: HandshakeAlarm) {
        print("Pressed")
    }
}

extension AlarmsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmsViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.name, for: indexPath) as? AlarmTableViewCell else {
            return UITableViewCell()
        }
        
        guard let data = alarmsViewData[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(with: data)
        return cell
    }
}

extension AlarmsListViewController: UITableViewDelegate { }


