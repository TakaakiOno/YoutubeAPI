//
//  Extensions.swift
//  PerrySwift
//
//  Created by ONOTAKAAKI on 2015/02/22.
//  Copyright (c) 2015年 ytapps. All rights reserved.
//

import Foundation

extension NSDictionary{
    
    func toQuery() -> String{
        var query :String = ""
        for keyObj in self.allKeys{
            let key = keyObj as String
            query = "\(query)&\(key)=\(self[key]!)"
        }
        var idx: String.Index
        idx = advance(query.startIndex, 1)
        query = query.substringFromIndex(idx)
        return query
    }
}

extension NSMutableDictionary{
    func merge(dictionary:NSDictionary) -> NSMutableDictionary{
        for keyObj in dictionary.allKeys{
            let key = keyObj as String
            self[key] = dictionary[key]
        }
        return self
    }
}

