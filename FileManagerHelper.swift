

import Foundation
import Combine
import AppKit

class FileManagerHelper: ObservableObject {
    @Published var fileTree: [String: [String]] = [:]
    @Published var openedFileContent: String = ""
    @Published var terminalOutput: String = ""

    var folderURL: URL? // Needed to track the folder selected

    func pickFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK, let url = panel.url {
            folderURL = url
            loadFiles()
        }
    }

    func createNewFile() {
        guard let folderURL = folderURL else { return }
        let newFileURL = folderURL.appendingPathComponent("NewFile.swift")
        let defaultContent = "// New Swift File"
        do {
            try defaultContent.write(to: newFileURL, atomically: true, encoding: .utf8)
            loadFiles()
        } catch {
            print("Failed to create file: \(error)")
        }
    }

    func openFile(inFolder folder: String, named fileName: String) {
        guard let folderURL = folderURL else { return }
        let fileURL = folderURL.appendingPathComponent(folder).appendingPathComponent(fileName)
        do {
            openedFileContent = try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("Failed to open file: \(error)")
        }
    }

    func loadFiles() {
        guard let folderURL = folderURL else { return }
        var tree: [String: [String]] = [:]

        do {
            let folders = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            for folder in folders where folder.hasDirectoryPath {
                let files = try FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil)
                tree[folder.lastPathComponent] = files.map { $0.lastPathComponent }
            }
            self.fileTree = tree
        } catch {
            print("Failed to load files: \(error)")
        }
    }

    func safeSave(contents: String) {
        guard let folderURL = folderURL else { return }
        let fileURL = folderURL.appendingPathComponent("SavedFile.swift")
        do {
            try contents.write(to: fileURL, atomically: true, encoding: .utf8)
            loadFiles()
        } catch {
            print("Save failed: \(error)")
        }
    }

    func safeExport(contents: String) {
        let panel = NSSavePanel()
        panel.title = "Export File"
        panel.nameFieldStringValue = "ExportedFile.swift"
        if panel.runModal() == .OK, let url = panel.url {
            do {
                try contents.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                print("Export failed: \(error)")
            }
        }
    }

    func runPython(_ code: String) {
        // You can replace this with real execution logic if needed
        terminalOutput += "$ python3 script.py\nSimulated Output\n"
    }
}
