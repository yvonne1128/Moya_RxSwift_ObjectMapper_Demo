import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authenticator: Authenticator
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            switch currentTab {
            case .Home:
                HomeView()
            case .Search:
                SearchView()
            case .Notifications:
                NotificationsView()
            case .Account:
                AccountView()
                    .environmentObject(authenticator)
            }
        }
        .overlay (
            TabButtonView(),
            alignment: .bottom
        )
    }
    
    @ViewBuilder
    func TabButtonView() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabButton(tab: tab)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            currentTab = tab
                        }
                    }
            }
        }
        .frame(width: nil, height: 60)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 16, x: 0, y: 8)
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        Button {
            withAnimation(.spring()) {
                currentTab = tab
            }
        } label: {
            Image(systemName: tab.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .scaleEffect(currentTab == tab ? 1.4 : 1)
                .frame(maxWidth: .infinity)
                .foregroundColor(
                    currentTab == tab ? Color(.systemBlue) : Color(.systemGray)
                )
                .shadow(
                    radius: currentTab == tab ? 6 : 0,
                    x: 0,
                    y: currentTab == tab ? 8 : 0
                )
        }

    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(Authenticator())
    }
}

enum Tab: String, CaseIterable {
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Notifications = "bell.fill"
    case Account = "person.fill"
//    case Logout = "door.left.hand.open"
}
