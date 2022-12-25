import Foundation

// MARK: Struct Convert To [String: Any]

protocol Convertable: Codable { }

extension Convertable {
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        
        return dict
    }
}
