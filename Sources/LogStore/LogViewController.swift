//
//  LogViewController.swift
//  
//
//  Created by Marcel Mierzejewski on 15/10/2020.
//

import UIKit

public class LogViewController: UITableViewController {
    
    let logItems = Array(LogStore.log.reversed())
    
    let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .short
      return dateFormatter
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LogCell")
        tableView.separatorStyle = .none
    }
}

extension LogViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logItems.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath)
        
        let logItem = logItems[indexPath.row]
        cell.textLabel?.text = "(\(dateFormatter.string(from: logItem.date))) \(logItem.text)"
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        if #available(iOS 13.0, *) {
            cell.textLabel?.font = .monospacedSystemFont(ofSize: 12, weight: .black)
        }
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
