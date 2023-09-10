//
//  URLencode.swift
//  앱개발 숙련 개인과제
//
//  Created by t2023-m0078 on 2023/08/29.
//

import Foundation

class urlEncode {
    
    var urlString:String?
    
    init(url: String){
        urlString = url
    }
    
    static func URLencode(_ str: String) -> URL {
        if let encoded = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let myURL = URL(string: encoded) {
            return myURL
        }
        else {
            return URL(string: "www.naver.com")!
        }
    }
}
