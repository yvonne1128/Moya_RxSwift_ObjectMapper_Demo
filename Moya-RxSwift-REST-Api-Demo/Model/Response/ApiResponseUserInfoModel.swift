import Foundation
import ObjectMapper

struct ApiResponseUserInfoModel: Mappable {
    var username: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        username <- map["username"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        password <- map["password"]
        phone <- map["phone"]
    }
}
