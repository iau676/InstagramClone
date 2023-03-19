//
//  NotificationController.swift
//  InstagramClone
//
//  Created by ibrahim uysal on 10.03.2023.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {
    
    //MARK: - Properties
    
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNotifications()
    }
    
    //MARK: - API
    
    private func fetchNotifications() {
        NotificationService.fetchNotification { notifications in
            self.notifications = notifications
            print("DEBUG: Notifications: \(notifications)")
        }
    }
    
    //MARK: - Helpers
    
    private func configureTableView() {
        view.backgroundColor = .white
        title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
}


//MARK: -

extension NotificationController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        
        return cell
    }
}
