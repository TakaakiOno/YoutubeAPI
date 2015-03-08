//
//  YoutubeAPIResponse.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/03/08.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import Foundation

    
// レスポンス型
class  YoutubeAPIResponse {

    var result: Base?
    var error: ErrorBase?
    let type: ResponseType
    
    enum ResponseType {
        case Error
        case Normal
    }
    
    
    init(responseDic:NSDictionary, responseType:ResponseType){
        switch responseType{
        case ResponseType.Error:
            error = ErrorBase(errorDic: responseDic)
        case ResponseType.Normal:
            result = Base(responseDict: responseDic)
        }
        self.type = responseType
    }
    
    
    
//        kind	string	API リソースのタイプ。値は youtube#searchListResponse です。
//        etag	etag	このリソースの Etag。
//        nextPageToken	string	結果セットの次のページを取得するために、pageToken パラメータの値として使用できるトークン。
//        prevPageToken	string	結果セットの前のページを取得するために、pageToken パラメータの値として使用できるトークン。
//        pageInfo	object	pageInfo オブジェクトは、結果セットのページング情報をカプセル化します。
//        pageInfo.totalResults	integer	結果セット内の結果の総数。
//        pageInfo.resultsPerPage	integer	API レスポンスに含まれる結果の数。
    struct Base {
        let kind :String!
        let etag :String!
        let nextPageToken :String?
        let prevPageToken :String?
        let pageInfo :PageInfo?
        let pageInfo_totalResults :Int?
        let pageInfo_resultsPerPage :Int?
        var items :[Any] = []
        
        init(responseDict: NSDictionary) {
            self.kind = responseDict["kind"] as String
            self.etag = responseDict["etag"] as String
            self.nextPageToken = responseDict["nextPageToken"] as String?
            self.prevPageToken = responseDict["prevPageToken"] as String?
            self.pageInfo = PageInfo(dictionary:responseDict["pageInfo"] as NSDictionary)
            self.pageInfo_resultsPerPage = responseDict["pageInfo.resultsPerPage"] as Int?
            self.pageInfo_totalResults = responseDict["pageInfo.totalResults"] as Int?
        }
    }
    
    struct PageInfo {
        let resultsPerPage :Int?
        let totalResults :Int?
        init(dictionary:NSDictionary){
            self.resultsPerPage = dictionary["resultsPerPage"] as Int?
            self.totalResults = dictionary["totalResults"] as Int?
        }
    }

    struct Snippet :Printable{
        
        let publishedAt :String?
        let channelId :String?
        let title :String?
        let _description :String?
        let channelTitle :String?
        let thumbnailMedium :Thumbnail?
        let thumbnailHigh :Thumbnail?
        let thumbnailDefault :Thumbnail?
        init(snippet: NSDictionary){
            self.publishedAt = snippet["publishedAt"] as String?
            self.channelId = snippet["channelId"] as String?
            self.title = snippet["title"] as String?
            self._description = snippet["description"] as String?
            self.channelTitle = snippet["channelTitle"] as String?
            let thumbnailDict :NSDictionary? = snippet["thumbnails"] as NSDictionary?
            if (thumbnailDict != nil){
                self.thumbnailDefault = Thumbnail(thumbnail: thumbnailDict!["default"] as NSDictionary?)
                self.thumbnailHigh = Thumbnail(thumbnail: thumbnailDict!["high"] as NSDictionary?)
                self.thumbnailMedium = Thumbnail(thumbnail: thumbnailDict!["medium"] as NSDictionary?)
            }
        }
        var description :String{
            var str = "{\n" +
            "  publishedAt = \(publishedAt),\n" +
            "  channelId = \(channelId),\n" +
            "  title = \(title),\n" +
            "  description = \(_description),\n"
            str = str +
            "  channelTitle = \(channelTitle),\n" +
            "  thumbnailDefault = \(thumbnailDefault),\n" +
            "  thumbnailMedium = \(thumbnailMedium),\n" +
            "  thumbnailHigh = \(thumbnailHigh),\n" +
            "}"
            return str
        }
    }
   
    
    struct Thumbnail :Printable{
        let url :String?
        let width :String?
        let height :String?
        init(thumbnail: NSDictionary?){
            if(thumbnail != nil){
                self.url = thumbnail!["url"] as String?
                self.width = thumbnail!["width"] as String?
                self.height = thumbnail!["height"] as String?
            }
        }
        var description :String{
            var str = "{\n" +
            "  url = \(url),\n" +
            "  width = \(width),\n" +
            "  height = \(height),\n" +
            "}"
            return str
        }
    }
    
    struct ErrorBase {
        let code: Int
        let errors: [Error] = []
        let message: String
        init(errorDic: NSDictionary){
//                println(errorDic)
            self.code = errorDic["code"] as Int
            self.message = errorDic["message"] as String
            let errorsArray = errorDic["errors"] as NSArray?
            if (errorsArray != nil){
                for (var i = 0; i < errorsArray!.count; i++){
                    self.errors.append(Error(errorDic: errorsArray![i] as NSDictionary))
                }
            }
        }
    }
    
    struct Error {
        let domain: String
        let extendedHelp: String?
        let message: String
        let reason: String
        init(errorDic: NSDictionary){
            self.domain = errorDic["domain"] as String
            self.extendedHelp = errorDic["extendedHelp"] as String?
            self.message = errorDic["message"] as String
            self.reason = errorDic["reason"] as String
        }
    }
    
}
