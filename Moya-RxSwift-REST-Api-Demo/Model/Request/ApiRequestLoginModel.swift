import Foundation
import ObjectMapper

struct ApiRequestLoginModel: Convertable {
    var email: String
    var password: String
}
