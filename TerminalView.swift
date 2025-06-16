
import SwiftUI

struct TerminalView: View {
    @State private var command: String = ""
    @State private var output: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Terminal")
                .font(.headline)
                .foregroundColor(.white)
            ScrollView {
                Text(output)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: 100)
            HStack {
                TextField("Enter command...", text: $command, onCommit: runCommand)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Run", action: runCommand)
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(12)
    }

    func runCommand() {
        output += "$ \(command)\nSimulated output\n"
        command = ""
    }
}
