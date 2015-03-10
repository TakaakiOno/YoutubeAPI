//
//  SearchTableViewCell.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/03/08.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func setContent(searchResult:YoutubeAPIResponse.Search){
//        println(searchResult)
        titleLabel.text = searchResult.snippet?.title
        
        if searchResult.id.kind == "youtube#playlist"{
            typeLabel.text = "playList"
        }
        else if searchResult.id.kind == "youtube#video"{
            typeLabel.text = "video"
        }
        else{
            typeLabel.text = ""
        }
        let URLString :String = (searchResult.snippet?.thumbnailDefault?.url)!
        var data = NSData(contentsOfURL: NSURL(string: URLString)!)
        self.thumbnailImage.image = UIImage(data: data!)
    }
    
    
}
