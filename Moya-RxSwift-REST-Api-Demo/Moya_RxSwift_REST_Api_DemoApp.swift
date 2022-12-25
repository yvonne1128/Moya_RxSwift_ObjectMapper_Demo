import SwiftUI

@main
struct Moya_RxSwift_REST_Api_DemoApp: App {
    @StateObject var authenticator = Authenticator()
    
    var body: some Scene {
        WindowGroup {
            if authenticator.isLogin {
                TabBarView()
                    .environmentObject(authenticator)
            } else {
                LoginView()
                    .environmentObject(authenticator)
            }
        }
    }
}
