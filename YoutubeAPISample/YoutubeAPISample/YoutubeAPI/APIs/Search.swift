//
//  YoutubeAPISearch.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/03/03.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import Foundation

extension YoutubeAPI{

    class Search: YoutubeAPI {
        
        var parameters :YoutubeAPI.Search.Parameter!
        

        // Init 
        convenience init(){
            self.init(uri: "/search")
            self.parameters = YoutubeAPI.Search.Parameter()
            self.apiType = YoutubeAPIType.Search
        }
        
        // Init with search parameters
        convenience init(parameters:YoutubeAPI.Search.Parameter){
            self.init()
            self.parameters = parameters
        }
        
        
        override func fetchAndParse() {
            if self.requestParameterDictionary == nil {
                self.requestParameterDictionary = self.parameters.toDictionary().mutableCopy() as NSMutableDictionary
            }
            super.fetchAndParse()
        }
        
        
        // parsing search api response
        override func parse(response: NSDictionary) {
            
            super.parse(response)
            
            // Error
            if (self.response?.type == YoutubeAPIResponse.ResponseType.Error){
                self.delegate.youtubeAPIRequestFailed(self.apiType, requestParameters:self.parameters, response: self.response?.error)
                return
            }
            
            let itemArray = response["items"] as NSArray?
            var items :[Any] = []
            for var i = 0; i < itemArray?.count; i++ {
                self.response?.result?.items.append(YoutubeAPIResponse.Search(itemDictionary: itemArray?[i] as NSDictionary))
            }
            
            // Succeed
            self.delegate.youtubeAPIRequestSucceed(self.apiType, requestParameters:self.parameters, response:self.response?.result)
        }
        
    }
}

extension YoutubeAPIResponse{

    // Search Response
    //  https://developers.google.com/youtube/v3/docs/search?hl=ja
    struct Search :Printable{
        var kind: String
        var etag: String
        var id: ID
        var snippet: Snippet?
        init(itemDictionary:NSDictionary){
            self.kind = itemDictionary["kind"] as String
            self.etag = itemDictionary["etag"] as String
            self.id = ID(idDictionary: itemDictionary["id"] as NSDictionary)
            if(itemDictionary["snippet"] != nil){
                self.snippet = Snippet(snippet: itemDictionary["snippet"] as NSDictionary)
            }
        }
        var description :String{
            let str = "{ \n  kind = \(kind) \n" +
            "  etag = \(etag), \n" +
            "  id = \(id), \n" +
            "  snippet = \(snippet), \n" +
            "}"
            return str
        }
    }
    
    struct ID :Printable{
        var kind: String
        var videoId: String?
        var channelId: String?
        var playlistId: String?
        init(idDictionary:NSDictionary){
            
            self.kind = idDictionary["kind"] as String
            self.videoId = idDictionary["videoId"] as String?
            self.channelId = idDictionary["channelId"] as String?
            self.playlistId = idDictionary["playlistId"] as String?
        }
        var description :String{
            return "{ \n" +
            "  kind = \(kind) \n" +
            "  videoId = \(videoId) \n" +
            "  channelId = \(channelId) \n" +
            "  playlistId = \(playlistId) \n" +
            "}"
        }
    }
}

// Search Parameter
//  https://developers.google.com/youtube/v3/docs/search/list?hl=ja
//
extension YoutubeAPI.Search{
    
    class Parameter :YoutubeAPIParameter{
        var part :String = "snippet"
        var filter :SearchFilterParam = SearchFilterParam.None
        var channelId :String?
        var channelType :ChannelType?
        var eventType :EventType?
        var maxResults :Int = 5
//        var onBehalfOfContentOwner :String?
        var order :Order?
        var pageToken :String?
        var publishedAfter :NSDate?
        var publishedBefore :NSDate?
        var q :String?
        var regionCode :String?
        var safeSearch :SafeSearch?
        var topicId :String?
        var type :Type?
        var videoCaption :VideoCaption?
        var videoCategoryId :String?
        var videoDifinition :VideoDefinition?
        var videoDimension :VideoDimension?
        var videoDuration :VideoDuration?
        var videoEmbeddable :VideoEmbeddable?
        var videoLicense :VideoLicense?
        var videoSyndicated :VideoSyndicated?
        var videoType :VideoType?
        
        override init(){
            
        }
        
        
        override func toDictionary() -> NSDictionary{
            var dictionary = NSMutableDictionary()
            
            dictionary["part"] = self.part
            if self.channelId != nil { dictionary["channelId"] = self.channelId }
            if self.channelType != nil { dictionary["channelType"] = self.channelType?.rawValue }
            if self.eventType != nil { dictionary["eventType"] = self.eventType?.rawValue }
            dictionary["maxResults"] = self.maxResults
            if self.order != nil { dictionary["order"] = self.order?.rawValue }
            if self.pageToken != nil { dictionary["pageToken"] = self.pageToken }
            if self.publishedAfter != nil { dictionary["publishedAfter"] = self.publishedAfter?.description }
            if self.publishedBefore != nil { dictionary["publishedBefore"] = self.publishedBefore?.description }
            if self.q != nil { dictionary["q"] = self.q!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) }
            if self.regionCode != nil { dictionary["regionCode"] = self.regionCode }
            if self.safeSearch != nil { dictionary["safeSearch"] = self.safeSearch?.rawValue }
            if self.topicId != nil { dictionary["topicId"] = self.topicId }
            if self.videoCaption != nil { dictionary["videoCaption"] = self.videoCaption?.rawValue }
            if self.videoCategoryId != nil { dictionary["videoCategoryId"] = self.videoCategoryId }
            if self.videoDifinition != nil { dictionary["videoDifinition"] = self.videoDifinition?.rawValue}
            if self.videoDimension != nil { dictionary["videoDimension"] = self.videoDimension?.rawValue }
            if self.videoDuration != nil { dictionary["videoDuration"] = self.videoDuration?.rawValue }
            if self.videoEmbeddable != nil { dictionary["videoEmbeddable"] = self.videoEmbeddable?.rawValue }
            if self.videoLicense != nil { dictionary["videoLicense"] = self.videoLicense?.rawValue }
            if self.videoSyndicated != nil { dictionary["videoSyndicated"] = self.videoSyndicated?.rawValue }
            if self.videoType != nil { dictionary["videoType"] = self.videoType?.rawValue }
            
            switch self.filter{
            case .ForContentOwner(let _onBehalfOfContentOwner):
                dictionary["onBehalfOfContentOwner"] = _onBehalfOfContentOwner
            case .ForMine:
                dictionary["type"] = Type.video.rawValue
            case .relatedToVideoId(let _videoId):
                dictionary["relatedToVideoId"] = _videoId
                dictionary["type"] = Type.video.rawValue
            default:
                break
            }
            
            return dictionary.copy() as NSDictionary
        }
        
        
        
        enum SearchFilterParam{
            case None
            case ForContentOwner(onBehalfOfContentOwner :String)
            case ForMine
            case relatedToVideoId(videoId :String)
        }
        enum ChannelType :String{
            case any = "any"
            case show = "show"
        }
        enum EventType :String{
            case completed = "completed"
            case live = "live"
            case upcoming = "upcoming"
        }
        enum Order :String{
            case date = "date"
            case rating = "rating"
            case relevance = "relevance"
            case title = "title"
            case videoCount = "videoCount"
            case viewCount = "viewCount"
        }
        enum SafeSearch :String{
            case moderate = "moderate"
            case none = "none"
            case strict = "strict"
        }
        enum Type :String{
            case channel = "channel"
            case playlist = "playlist"
            case video = "video"
        }
        enum VideoCaption :String{
            case any = "any"
            case closedCaption = "closedCaption"
            case none = "none"
        }
        enum VideoDefinition :String{
            case any = "any"
            case highResolution = "high"
            case standard = "standard"
        }
        enum VideoDimension :String{
            case any = "any"
            case d2 = "2d"
            case d3 = "3d"
        }
        enum VideoDuration :String{
            case any = "any"
            case long = "long"
            case short = "short"
            case medium = "medium"
        }
        enum VideoEmbeddable :String{
            case any = "any"
            case yes = "true"
        }
        enum VideoLicense :String{
            case any = "any"
            case creativeCommon = "creativeCommon"
            case youtube = "youtube"
        }
        enum VideoSyndicated :String{
            case any = "any"
            case yes = "true"
        }
        enum VideoType :String{
            case any = "any"
            case episode = "episode"
            case movie = "movie"
        }
    }
}

