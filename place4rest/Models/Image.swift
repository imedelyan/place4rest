//
//  Image.swift
//  place4rest
//
//  Created by Igor Medelian on 2/18/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import RealmSwift

@objcMembers
final class Image: Object {

    public dynamic var id: Int = 0
    public dynamic var date: String = ""
    public dynamic var status: String = ""
    public dynamic var title: String = ""
    public dynamic var url: String = ""
    public dynamic var desc: String = ""
    public dynamic var placeId: Int = 0
    public dynamic var previewURL: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    public convenience required init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.container(keyedBy: RootKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        date = try container.decode(String.self, forKey: .date)
        status = try container.decode(String.self, forKey: .status)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        desc = try container.decode(String.self, forKey: .description)
        placeId = try container.decode(Int.self, forKey: .placeId)

        // sizes
        let sizesContainer = try container.nestedContainer(keyedBy: SizesKeys.self, forKey: .sizes)
        previewURL = try sizesContainer.decode(String.self, forKey: .previewURL)
    }
}

extension Image: Decodable {
    enum RootKeys: String, CodingKey {
        case id, date, status, title, url, description, sizes
        case placeId = "uploaded_to"
    }

    enum SizesKeys: String, CodingKey {
        case previewURL = "medium"
    }
}
