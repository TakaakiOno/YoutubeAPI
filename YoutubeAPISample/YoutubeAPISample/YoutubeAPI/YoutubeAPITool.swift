//
//  YoutubeAPITool.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/03/08.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import Foundation

class YoutubeAPITool: NSObject {
    
    
    
    class func embedURLFromSearchResult(result:YoutubeAPIResponse.Search) -> NSURL{
        if result.id.videoId != nil {
            return YoutubeAPITool.embedURLFromVideoId((result.id.videoId)!)
        }
        else if result.id.playlistId != nil {
            return YoutubeAPITool.embedURLFromPlayListId((result.id.playlistId)!)
        }
        return NSURL()
    }
    
    class func embedURLFromVideoId(videoId:String) -> NSURL{
        let urlString = "https://www.youtube.com/embed/\(videoId)"
        return NSURL(string: urlString)!
    }
    
    class func embedURLFromPlayListId(playlistId:String) ->NSURL{
        let urlString = "https://www.youtube.com/embed/?listType=playlist&list=\(playlistId)"
        return NSURL(string: urlString)!
    }
}
