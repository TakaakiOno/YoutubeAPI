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
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var searchAPI = YoutubeAPI.Search()
        searchAPI.delegate = self
        searchAPI.parameters.q = "pitbull song"
        searchAPI.parameters.maxResults = 50
        searchAPI.fetchAndParse()
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
        self.searchResult = (response?.items)!
        self.tableview.reloadData()
    }
    
    
    // MARK: tableview
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :SearchTableViewCell? = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell") as? SearchTableViewCell
        cell!.setContent(self.searchResult[indexPath.row] as YoutubeAPIResponse.Search)
        return cell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count :Int? = self.searchResult.count
        if count != nil {
            return count!;
        }
        return 0
    }
}

