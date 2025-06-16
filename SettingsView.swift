

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.title)
                .bold()

            Toggle("Dark Mode", isOn: .constant(true))
                .disabled(true)

            Picker("Font Size", selection: .constant(14)) {
                ForEach([12, 14, 16, 18], id: \.self) {
                    Text("\($0) pt")
                }
            }
            .disabled(true)

            Divider()

            Text("Credits")
                .font(.headline)
            Text("Created by Westmoon05")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
