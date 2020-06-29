// Dangerfile.swift

import Danger
import DangerSwiftLint // package: https://github.com/ashfurrow/danger-swiftlint.git

SwiftLint.lint(directory: "Sources", configFile: ".github/workflows/swiftlint.yml")
