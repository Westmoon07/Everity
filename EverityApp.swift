import SwiftUI

@main
struct EverityApp: App {
    @StateObject private var fileManager = FileManagerHelper()
    @StateObject private var editorState = EditorState()

    @State private var showSettingsWindow = false

    var body: some Scene {
        WindowGroup {
            ContentView(showSettingsWindow: $showSettingsWindow)
                .environmentObject(fileManager)
                .environmentObject(editorState)
        }

        // New dedicated Settings window
        Window("Settings", id: "Settings") {
            SettingsView()
                .frame(width: 400, height: 300)
        }
    }
}
