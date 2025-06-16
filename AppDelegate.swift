

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    @objc func openSettings() {
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }
}
