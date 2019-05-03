//
//  Place.swift
//  place4rest
//
//  Created by Igor Medelian on 2/18/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import RealmSwift

@objcMembers
final class Place: Object {

    public dynamic var id: Int = 0
    public dynamic var date: String = ""
    public dynamic var status: String = ""
    public dynamic var type: String = ""
    public dynamic var title: String = ""
    public dynamic var latitude: Double = 0.0
    public dynamic var longitude: Double = 0.0
    public dynamic var markerURL: String = ""
    public dynamic var content: String = ""
    public var categories = List<Int>()
    public var categoriesFor = List<Int>()
    public var services = List<Int>()
    public var activities = List<Int>()
    public dynamic var featuredImage: Image?
    public var images = List<Image>()

    override static func primaryKey() -> String? {
        return "id"
    }

    public convenience required init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.container(keyedBy: RootKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        date = try container.decode(String.self, forKey: .date)
        status = try container.decode(String.self, forKey: .status)
        type = try container.decode(String.self, forKey: .type)

        // title
        let titleContainer = try container.nestedContainer(keyedBy: TitleKeys.self, forKey: .title)
        title = try titleContainer.decode(String.self, forKey: .rendered)

        // categories, activities
        if let categoriesArray = try? container.decode([Int].self, forKey: .categories) {
            categories.append(objectsIn: categoriesArray)
        }
        if let categoriesForArray = try? container.decode([Int].self, forKey: .categoriesFor) {
            categoriesFor.append(objectsIn: categoriesForArray)
        }
        if let servicesArray = try? container.decode([Int].self, forKey: .services) {
            services.append(objectsIn: servicesArray)
        }
        if let activitiesArray = try? container.decode([Int].self, forKey: .activities) {
            activities.append(objectsIn: activitiesArray)
        }

        // marker, content
        markerURL = (try container.decode([String].self, forKey: .markerURL)).first ?? ""
        content = (try container.decode([String].self, forKey: .content)).first ?? ""

        // latitude, longitude
        latitude = Double(((try container.decode([String].self, forKey: .latitude)).first ?? "").trim()) ?? 0.0
        longitude = Double(((try container.decode([String].self, forKey: .longitude)).first ?? "").trim()) ?? 0.0

        // acf
        let falseValue = try? container.decodeIfPresent(Bool.self, forKey: .acf)
        if falseValue == nil {
            let acfContainer = try container.nestedContainer(keyedBy: ACFKeys.self, forKey: .acf)
            featuredImage = try acfContainer.decode(Image.self, forKey: .featuredImage)

            // images
            var imagesContainer = try acfContainer.nestedUnkeyedContainer(forKey: .images)
            var imagesArray: [Image] = []
            while !imagesContainer.isAtEnd {
                let imageContainer = try imagesContainer.nestedContainer(keyedBy: ImagesKeys.self)
                imagesArray.append(try imageContainer.decode(Image.self, forKey: .image))
            }
            images.append(objectsIn: imagesArray)
        }
    }
}

extension Place: Decodable {
    enum RootKeys: String, CodingKey {
        case id, date, status, type, title, acf
        case latitude = "free4rest_front_lat"
        case longitude = "free4rest_front_lon"
        case categories = "cat_place"
        case categoriesFor = "cat_place_for"
        case services = "cat_services"
        case activities = "cat_activity"
        case markerURL = "locate-anything-default-marker-media"
        case content = "free4rest_front_content"
    }

    enum TitleKeys: String, CodingKey {
        case rendered
    }

    enum ACFKeys: String, CodingKey {
        case featuredImage = "free4rest_front_featured_img"
        case images = "free4rest_front_gallery"
    }

    enum ImagesKeys: String, CodingKey {
        case image = "free4rest_front_gallery_img"
    }
}

extension Place {
    enum Status: String {
        case publish
        case draft
    }
}
