//
//  NewsController.swift
//  WoWs Info
//
//  Created by Henry Quan on 25/3/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit
import SafariServices

class NewsController: UITableViewController, SFSafariViewControllerDelegate {

    var newsData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Automatic row height and remove separator line
        self.tableView.separatorColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70.0
        
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("WEB_LOADING", comment: "Loading news")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if newsData.count == 0 {
            News().getNews(success: { (data) in
                DispatchQueue.main.async {
                 self.newsData = data
                    if self.newsData.count > 0 {
                        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("NEWS", comment: "News label")
                    } else {
                        self.navigationController?.navigationBar.topItem?.title = ">_<"
                    }
                    // Change view background colour to theme colour
                    self.tableView.backgroundColor = Theme.getCurrTheme()
                    // Reload data for animation
                    self.tableView.reloadData()
                    self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows!, with: .automatic)
                }
            })
        } else {
            // Change view background colour to theme colour
            self.tableView.backgroundColor = Theme.getCurrTheme()
            // Reload data for animation
            self.tableView.reloadData()
            self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows!, with: .automatic)
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
            cell.backgroundColor = Theme.getCurrTheme()
            cell.dateLabel.textColor = UIColor.white
            cell.titleLabel.textColor = UIColor.white
            
            cell.titleLabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.medium)
            cell.dateLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        } else {
            cell.backgroundColor = UIColor.white
            cell.dateLabel.textColor = UIColor.black
            cell.titleLabel.textColor = UIColor.black
            
            cell.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
            cell.dateLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let browser = SFSafariViewController(url: URL(string: newsData[indexPath.row][News.dataIndex.link])!)
        browser.delegate = self
        browser.modalPresentationStyle = .overFullScreen
        // Change status bar
        UIApplication.shared.statusBarStyle = .default
        self.present(browser, animated: true, completion: nil)
        
        // Deselect cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Safari
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // Change status bar
        UIApplication.shared.statusBarStyle = .lightContent
        controller.dismiss(animated: true, completion: nil)
    }

}
