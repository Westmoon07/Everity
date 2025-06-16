import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fileManager: FileManagerHelper
    @EnvironmentObject var editorState: EditorState
    @Binding var showSettingsWindow: Bool
    @State private var codeText = "# Start coding here"
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color(fromHex: "#FF3B2F"), Color(fromHex: "#FF9500")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    // Left Sidebar
                    VStack(spacing: 20) {
                        Button(action: { fileManager.pickFolder() }) {
                            Image(systemName: "folder.badge.plus")
                        }
                        Button(action: { fileManager.createNewFile() }) {
                            Image(systemName: "doc.badge.plus")
                        }
                        
                        Spacer()
                        
                        SettingsLink {
                            Image(systemName: "gearshape")
                        }
                    }
                    .padding()
                    .frame(width: 50)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    
                    // File Explorer
                    VStack(alignment: .leading) {
                        Text("EXPLORER")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .padding([.top, .leading])
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(fileManager.fileTree.sorted(by: { $0.key < $1.key }), id: \.key) { folder, files in
                                    Text("📁 \(folder)")
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                    
                                    ForEach(files, id: \.self) { name in
                                        Text("📄 \(name)")
                                            .foregroundColor(.white.opacity(0.85))
                                            .padding(.leading, 20)
                                            .onTapGesture {
                                                fileManager.openFile(inFolder: folder, named: name)
                                                codeText = fileManager.openedFileContent
                                            }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: 200)
                    .background(Color.black.opacity(0.4))
                    
                    // Code Editor Panel
                    VStack(spacing: 0) {
                        // Top bar with language + actions
                        HStack {
                            Picker(selection: $editorState.language, label: Text("Language")) {
                                ForEach(["python", "html", "javascript", "swift"], id: \.self) { language in
                                    Text(language.capitalized).tag(language)
                                }
                            }
                            .pickerStyle(PopUpButtonPickerStyle())
                            .frame(width: 140)
                            .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button("Save") {
                                fileManager.safeSave(contents: codeText)
                            }
                            Button("Export") {
                                fileManager.safeExport(contents: codeText)
                            }
                            if editorState.language == "python" {
                                Button("Run") {
                                    fileManager.runPython(codeText)
                                }
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.3))
                        
                        // Main code editor
                        VStack(spacing: 12) {
                            TextEditor(text: $codeText)
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.95))
                                .cornerRadius(10)
                            
                            
                        }
                    }
                }
            }
        }
    }
}
