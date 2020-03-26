//
//  Information.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/11/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class Fact: Codable {

    var id: Int?
    var title: String?
    var category: String?
    var content: String?
    var imageURL: String?
    var image: UIImage?

    init(
        id: Int? = -1,
        title: String? = "",
        category: String? = "",
        content: String? = "",
        imageURL: String? = "",
        image: UIImage? = nil
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.content = content
        self.imageURL = imageURL
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "fact_title"
        case category = "fact_category"
        case content = "fact_content"
        case imageURL = "fact_image"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
}
