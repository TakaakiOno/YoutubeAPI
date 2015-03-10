//
//  ViewController.swift
//  YoutubeAPISample
//
//  Created by ONOTAKAAKI on 2015/03/08.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YoutubeAPIDelegate{

    var searchResult :[Any] = []
    var searchAPI :YoutubeAPI.Search!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.searchAPI = YoutubeAPI.Search()
        self.searchAPI.delegate = self
        self.searchAPI.parameters.q = "pitbull song"
        self.searchAPI.parameters.maxResults = 50
        self.searchAPI.fetchAndParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: YoutubeAPIDelegate
    
    func youtubeAPIRequestFailed(apiType: YoutubeAPIType, requestParameters: Any, response: YoutubeAPIResponse.ErrorBase?) {
        // Erorr
    }
    
    func youtubeAPIRequestSucceed(apiType: YoutubeAPIType, requestParameters: Any, response: YoutubeAPIResponse.Base?) {
        // Success
        var count = response?.items.count
        for (var i = 0; i < count; i++){
            self.searchResult.append(response?.items[i] as YoutubeAPIResponse.Search)
        }
//        self.searchResult = (response?.items)!
        self.tableview.reloadData()
    }
    
    
    // MARK: tableview
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :SearchTableViewCell? = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell") as? SearchTableViewCell
        cell!.setContent(self.searchResult[indexPath.row] as YoutubeAPIResponse.Search)
        
        if indexPath.row == self.searchResult.count - 1 {
            self.searchAPI.next()
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count :Int? = self.searchResult.count
        if count != nil {
            return count!;
        }
        return 0
    }
}

