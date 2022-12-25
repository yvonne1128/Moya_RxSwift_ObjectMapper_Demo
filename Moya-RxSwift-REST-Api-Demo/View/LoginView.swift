import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticator: Authenticator
    
    @StateObject var vm = LoginVM()
    @StateObject var loadingVM = LoadingVM.instance
    
    @State private var email = "eve.holt@reqres.in"
    @State private var password = "cityslicka"
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 9, x: 10, y: 10)
                    .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(25)
                        .shadow(radius: 10, x: 5, y: 10)
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(25)
                        .shadow(radius: 10, x: 5, y: 10)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                
                if authenticator.loginError != "" {
                    Text(authenticator.loginError)
                        .font(.title3)
                        .foregroundColor(.red)
                        .bold()
                        .padding()
                }
                                
                Button {
                    authenticator.loginError = ""
                    authenticator.login(email: email, password: password)
                } label: {
                    if loadingVM.isLoading {
                        LoadingView(color: Color.white)
                    } else {
                        Text("Sign in")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .frame(width: 200, height: 60)
                .background(
                    email == "" && password == "" ? .gray : .orange
                )
                .cornerRadius(30)
                .shadow(radius: 10, x: 20, y: 10)
                .padding(.top, 8)
                .disabled(email == "" && password == "")

                Spacer()
                
                HStack {
                    Text("Don't have an account? ")
                        .foregroundColor(.white)
                    
                    Button {
                        
                    } label: {
                        Text("Sign up")
                            .foregroundColor(.yellow)
                            .bold()
                    }

                }
            }
            .background {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color(.systemMint),
                            Color(.systemBlue)
                        ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
        .fullScreenCover(isPresented: $authenticator.isLogin) {
            TabBarView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Authenticator())
    }
}
