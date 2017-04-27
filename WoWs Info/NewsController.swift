//
//  NewsController.swift
//  WoWs Info
//
//  Created by Henry Quan on 25/3/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit

class NewsController: UITableViewController {

    var newsData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Automatic row height and remove separator line
        self.tableView.separatorColor = UIColor.clear
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("WEB_LOADING", comment: "Loading news")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if newsData.count == 0 {
            newsData = News().getNews()
            if newsData.count > 0 {
                self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("NEWS", comment: "News label")
            } else {
                self.navigationController?.navigationBar.topItem?.title = ">_<"
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsData.count > 0 {
            return newsData.count
        } else { return 0 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.dateLabel.text = newsData[indexPath.row][News.dataIndex.time]
        cell.titleLabel.text = newsData[indexPath.row][News.dataIndex.title]
        
        // Headlines
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.init(red: 112/255, green: 177/255, blue: 251/255, alpha: 1)
            cell.dateLabel.textColor = UIColor.white
            cell.titleLabel.textColor = UIColor.white
            
            cell.titleLabel.font = UIFont.systemFont(ofSize: 26, weight: UIFontWeightMedium)
            cell.dateLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        } else {
            cell.backgroundColor = UIColor.white
            cell.dateLabel.textColor = UIColor.black
            cell.titleLabel.textColor = UIColor.black
            
            cell.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
            cell.dateLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "gotoWebView", sender: newsData[indexPath.row][News.dataIndex.link])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Change text to "Back"
        let backItem = UIBarButtonItem()
        backItem.title = NSLocalizedString("BACK", comment: "Back button")
        navigationItem.backBarButtonItem = backItem
        
        // Go to WebView
        if segue.identifier == "gotoWebView" {
            let destination = segue.destination as! WebViewController
            destination.url = sender as! String
        }
    }

}
