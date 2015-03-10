//
//  YoutubeAPI.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/02/21.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import Foundation

protocol YoutubeAPIDelegate{
    func youtubeAPIRequestSucceed(apiType:YoutubeAPIType, requestParameters:Any, response:YoutubeAPIResponse.Base?)
    func youtubeAPIRequestFailed(apiType:YoutubeAPIType, requestParameters:Any, response:YoutubeAPIResponse.ErrorBase?)
}


// リクエスト型
protocol YoutubeAPIParameterDelegate{
    func toDictionary() -> NSDictionary
}


// API Type
enum YoutubeAPIType {
    case Search
}

class YoutubeAPI: NSObject {
    
    // レスポンス結果
    var response :YoutubeAPIResponse?
    
    // Delegate
    var delegate :YoutubeAPIDelegate!
    
    // API URL
    var baseURL :String = "https://www.googleapis.com/youtube/v3"
    
    // Request
    var requestParameterDictionary :NSMutableDictionary!
    
    var requestURL :String!
    
    private var request :YoutubeAPIRequest = YoutubeAPIRequest()
    private let APIKey :String
    

    
    var apiType :YoutubeAPIType!
    
    
    init(uri: String) {
        self.baseURL = baseURL + uri
        let path = NSBundle.mainBundle().pathForResource("YoutubeAPISetting", ofType: "plist")
        let data = NSDictionary(contentsOfFile: path!)
        self.APIKey = data?.objectForKey("API_KEY") as String
        super.init()
    }
    
    func fetchAndParse(){
        
        // fetch
        self.requestParameterDictionary["key"] = self.APIKey
        self.requestURL = self.baseURL + "?" + self.requestParameterDictionary.toQuery()
        println(self.requestURL)
        
        request.jsonRequestFromURL(self.requestURL, {() in
            // parse
            self.parse(self.request.responseDictionary)
        })
    }
    
    
    func parse(response: NSDictionary){
        // Check errors
        self.errorCheck(response)
    }
    
    func errorCheck(response: NSDictionary){
        let errors = response["error"] as NSDictionary?
        if (errors != nil){
            // Error
            self.response = YoutubeAPIResponse(responseDic: errors!, responseType: YoutubeAPIResponse.ResponseType.Error)
            println("Youtube API Error \n \(self.response!.error!.message)")
            println(errors)
            return
        }
        
        // Succeed
        self.response = YoutubeAPIResponse(responseDic: response, responseType: YoutubeAPIResponse.ResponseType.Normal)
    }
    
    
    func next(){
        if self.response?.result?.nextPageToken != nil {
            self.requestParameterDictionary["pageToken"] = self.response?.result?.nextPageToken
            self.fetchAndParse()
        }
    }
    
    
    func prev(){
        if self.response?.result?.prevPageToken != nil {
            self.requestParameterDictionary["pageToken"] = self.response?.result?.prevPageToken
            self.fetchAndParse()
        }
    }
    
    
    class YoutubeAPIParameter :YoutubeAPIParameterDelegate{
        func toDictionary() -> NSDictionary {
            return NSDictionary()
        }
    }
}


