import SwiftUI
import shared

func greet() -> String {
    return Greeting().greeting()
}

struct ContentView: View {
   @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        NavigationView {
            listView()
            .navigationBarTitle("SpaceX Launches")
            .navigationBarItems(trailing:
                Button("Reload") {
                    self.viewModel.loadLaunches(forceReload: true)
            })
        }
    }

    private func listView() -> AnyView {
        switch viewModel.launches {
        case .loading:
            return AnyView(Text("Loading...").multilineTextAlignment(.center))
        case .result(let launches):
            return AnyView(List(launches) { launch in
                RocketLaunchRow(rocketLaunch: launch)
            })
        case .error(let description):
            return AnyView(Text(description).multilineTextAlignment(.center))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    class ViewModel: ObservableObject {
        let sdk: SpaceXSDK
        @Published var launches = LoadableLaunches.loading

        init(sdk: SpaceXSDK) {
            self.sdk = sdk
            self.loadLaunches(forceReload: false)
        }

        func loadLaunches(forceReload: Bool) {
           // TODO: retrieve data
        }
    }
    
    enum LoadableLaunches {
        case loading
        case result([RocketLaunch])
        case error(String)
    }

    class ViewModel: ObservableObject {
        @Published var launches = LoadableLaunches.loading
    }
}
