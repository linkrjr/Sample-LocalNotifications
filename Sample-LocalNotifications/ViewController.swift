//
//  ViewController.swift
//  Sample-LocalNotifications
//
//  Created by Ronaldo GomesJr on 24/11/2015.
//  Copyright © 2015 TechnophileIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    private var notificationsTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Local Notifications"
        
        let addBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addNotification:")
        
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        
        self.notificationsTableView = UITableView()
        self.notificationsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.notificationsTableView.dataSource = self
        self.notificationsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(self.notificationsTableView)
        
        let views = ["notificationsTableView": self.notificationsTableView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[notificationsTableView]|", options: .AlignAllTop, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[notificationsTableView]|", options: .AlignAllLeft, metrics: nil, views: views))

    }

    func addNotification(sender:AnyObject) {
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 2 * 60)
        localNotification.alertAction = "show me the item"
        localNotification.alertBody = "Notification"
//        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
//        NSNotificationCenter.defaultCenter().postNotificationName("reloadData", object: self)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//        UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
        
        self.notificationsTableView.reloadData()
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let notifications = UIApplication.sharedApplication().scheduledLocalNotifications
        let notification = notifications![indexPath.row] as UILocalNotification
        
        cell.textLabel!.text = notification.alertBody
        cell.detailTextLabel?.text = notification.fireDate?.description
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().scheduledLocalNotifications?.count)!
    }
    
}

