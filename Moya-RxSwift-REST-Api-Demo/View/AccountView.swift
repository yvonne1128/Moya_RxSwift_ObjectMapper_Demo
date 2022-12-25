import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        Button {
            authenticator.logout()
        } label: {
            Text("Logout")
            .font(.title)
            .bold()
            .padding()
            .foregroundColor(.white)
        }
        .background(Color(.systemRed))
        .cornerRadius(16)
        .shadow(radius: 8, x: 0, y: 8)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(Authenticator())
    }
}
