//
//  FeedModel.swift
//  Smoothie
//
//  Created by Ajay Yadav on 25/09/21.
//

import Foundation

struct FeedModel : Codable {
    let data : [DataModel]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([DataModel].self, forKey: .data)
    }

}
