//
//  FeedDataModel.swift
//  Smoothie
//
//  Created by Ajay Yadav on 25/09/21.
//

import UIKit

class FeedDataModel: NSObject {
    
    var isDataLoaded:((Bool)->Void)?
    var arrFeedList:[DataModel] = []
    
    func getFeedList(urlStr:String){
        ServerCommunication.getData(urlStr: urlStr) { data in
            if let data = data as? Data{
                self.parseData(data: data)
            }
        }
    }
    
    func parseData(data:Data){
        let jsonStr = String(data: data, encoding: .utf8)
        let value =  jsonStr
        if let data = value?.replacingOccurrences(of: "\n", with: "").data(using: String.Encoding.utf8) {
            do {
                let arrData = try JSONDecoder().decode(FeedModel.self, from: data)
                arrFeedList = arrData.data ?? []
                isDataLoaded?(true)
                
            } catch {
                NSLog("ERROR \(error.localizedDescription)")
            }
        }
    }
    
    
    func heightForRowAtIndexPath()->CGFloat{
        return 500.0
    }
}
