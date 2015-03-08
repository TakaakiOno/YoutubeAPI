//
//  NetworkRequests.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/02/21.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import UIKit


class YoutubeAPIRequest: NSObject {
    
    var responseDictionary: NSDictionary!
    
    func jsonRequestFromURL(urlString: String, completion: ()->Void){
        let url:NSURL! = NSURL(string:urlString)
        let urlRequest:NSURLRequest = NSURLRequest(URL:url)
        
        // request async
        NSURLConnection.sendAsynchronousRequest(
            urlRequest,
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{(response,jsonData,error) -> Void in
                
                // store to dictionary
                self.responseDictionary = NSJSONSerialization.JSONObjectWithData(
                    jsonData!,
                    options: NSJSONReadingOptions.AllowFragments,
                    error: nil) as NSDictionary
                
                completion()
        })
    }

    
}
