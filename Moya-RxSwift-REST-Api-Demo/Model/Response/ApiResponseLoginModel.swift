import Foundation
import ObjectMapper

struct ApiResponseLoginModel: Mappable {
    var token: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}
