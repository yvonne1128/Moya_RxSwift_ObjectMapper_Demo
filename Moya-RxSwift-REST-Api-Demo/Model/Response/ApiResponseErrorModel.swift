import Foundation
import ObjectMapper

struct ApiResponseErrorModel: Mappable, Error {
    var errorMessage: String = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        errorMessage <- map["error"]
    }
}
