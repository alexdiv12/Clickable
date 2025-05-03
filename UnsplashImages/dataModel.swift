//
//  dataModel.swift
//  UnsplashImages
//
//  Created by Divyanshu rai on 13/09/24.
//

import Foundation
struct Photos:Codable,Hashable, Identifiable {
    
    static func == (lhs: Photos, rhs: Photos) -> Bool {
        lhs.id==rhs.id
    }
    
    var id: String
    var urls: Urls
    var description:String?
    var alt_description:String?
    var created_at:String
    var updated_at:String
    static let mock = Photos(id: "mockId", urls: Urls(regular: "https://example.com/mock-image.jpg"),description: "description",alt_description: "alt_description",created_at: "2023",updated_at: "2023")

}
struct Urls:Codable,Hashable{
    var regular:String
}

