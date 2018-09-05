//
//  Exercise.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/4/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class Track: Codable {

    var id: Int?
    var title: String?
    var trackDescription: String?
    var duration: Float?
    var imageURL: String?
    var audioURL: String?
    var meteringLevels: [Float]?
    var image: UIImage?

    init(
        id: Int? = 0,
        title: String? = "",
        description: String? = "",
        duration: Float? = 0.0,
        imageURL: String? = "",
        audioURL: String? = "",
        meteringLevels: [Float]? = [0.0],
        image: UIImage? = nil
    ) {
        self.id = id
        self.title = title
        self.trackDescription = description
        self.duration = duration
        self.imageURL = imageURL
        self.meteringLevels = meteringLevels
        self.image = image
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case title = "track_name"
        case trackDescription = "track_description"
        case imageURL = "track_image"
        case audioURL = "track_audio"
        case duration = "track_duration"
        case meteringLevels = "track_metering_levels"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        trackDescription = try container.decodeIfPresent(String.self, forKey: .trackDescription)
        duration = try container.decodeIfPresent(Float.self, forKey: .duration)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        audioURL = try container.decodeIfPresent(String.self, forKey: .audioURL)
        meteringLevels = try container.decodeIfPresent([Float].self, forKey: .meteringLevels)
    }

}
